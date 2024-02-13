import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/user_dto.dart';
import 'package:SoulSync/screens/view_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final _userList = <UserDto>[];

  var _isLoading = false;
  var _hasSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: Container(
          padding: const EdgeInsets.only(
            top: 40,
            left: 6,
            right: 32,
            bottom: 24,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF044051),
                Color(0xFF135263),
                Color(0xFF35788A),
                Color(0xFF35778A),
                Color(0xFF43879A),
                Color(0xFF5AA1B5),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Profiles...",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: const Icon(Icons.search, size: 25),
                    ),
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: _onSearch,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Visibility(
          visible: _userList.isNotEmpty || !_hasSearch,
          replacement: const Center(
            child: Text('User not Found'),
          ),
          child: ListView.builder(
            itemCount: _userList.length,
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemBuilder: (ctx, idx) {
              final user = _userList[idx];

              return GestureDetector(
                onTap: () {
                  _onViewUser(user.email);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userList[idx].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _userList[idx].email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onSearch(String query) async {
    setState(() {
      _isLoading = true;
      _hasSearch = true;
    });

    final newQuery = query.toLowerCase();
    final result = await FirebaseFirestore.instance
        .collection(CollectionConstant.users)
        .get();
    // .orderBy(CollectionConstant.userNameLower)
    // .startAt([newQuery]).endAt(['$newQuery\uf8ff']).get();

    final filtered = result.docs.where((element) {
      return element
          .data()[CollectionConstant.userName]
          .toString()
          .toLowerCase()
          .contains(newQuery);
    });

    setState(() {
      _isLoading = false;

      _userList.clear();
      _userList.addAll(filtered.map((e) {
        return UserDto(
          id: e.id,
          name: e.data()[CollectionConstant.userName],
          email: e.data()[CollectionConstant.userEmail],
          phone: e.data()[CollectionConstant.userPhone],
        );
      }));
    });
  }

  void _onViewUser(String email) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return ViewProfilePage(email: email);
    }));
  }
}
