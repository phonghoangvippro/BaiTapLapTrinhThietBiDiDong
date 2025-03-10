import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LibraryHomePage(),
      routes: {
        '/users': (context) => const UserListPage(),
        '/borrow': (context) => const BorrowBookPage(),
      },
    );
  }
}

// Models
class BookItem {
  final int id;
  final String title;
  final String author;
  final bool isAvailable;
  bool isSelected;

  BookItem({
    required this.id,
    required this.title,
    this.author = 'Tác giả',
    this.isAvailable = true,
    required this.isSelected,
  });
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final List<BookItem> borrowedBooks;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.borrowedBooks = const [],
  });
}

// Main Library Home Page
class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final TextEditingController _staffNameController = TextEditingController(text: 'Nguyen Van A');
  final List<BookItem> _books = [
    BookItem(id: 1, title: 'Sách 01', author: 'Tác giả A', isSelected: false),
    BookItem(id: 2, title: 'Sách 02', author: 'Tác giả B', isSelected: false),
    BookItem(id: 3, title: 'Sách 03', author: 'Tác giả C', isSelected: false),
  ];
  int _currentIndex = 0;

  @override
  void dispose() {
    _staffNameController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/users');
    } else if (index == 2) {
      // Account page would go here
    }
  }

  void _addNewBook() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm sách mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Tên sách',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Tác giả',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _books.add(BookItem(
                  id: _books.length + 1,
                  title: 'Sách ${_books.length + 1}',
                  author: 'Tác giả mới',
                  isSelected: false,
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Hệ thống\nQuản lý Thư viện',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhân viên',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _staffNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(60, 48),
                      ),
                      child: const Text('Đổi'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Danh sách sách',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_books.any((book) => book.isSelected)) {
                          Navigator.pushNamed(context, '/borrow');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng chọn ít nhất một sách để mượn'),
                            ),
                          );
                        }
                      },
                      child: const Text('Mượn sách',),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: _books.map((book) => _buildBookItem(book)).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _addNewBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Thêm'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildBookItem(BookItem book) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: CheckboxListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title),
            Text(
              book.author,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        subtitle: Text(
          book.isAvailable ? 'Sẵn sàng' : 'Đã mượn',
          style: TextStyle(
            color: book.isAvailable ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: book.isSelected,
        activeColor: Colors.red,
        checkColor: Colors.white,
        onChanged: book.isAvailable
            ? (bool? value) {
          setState(() {
            book.isSelected = value ?? false;
          });
        }
            : null,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Hồ sơ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// User List Page
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final List<UserModel> _users = [
    UserModel(
      id: 1,
      name: 'Nguyễn Văn A',
      email: 'nguyenvana@example.com',
      borrowedBooks: [],
    ),
    UserModel(
      id: 2,
      name: 'Trần Thị B',
      email: 'tranthib@example.com',
      borrowedBooks: [],
    ),
    UserModel(
      id: 3,
      name: 'Lê Văn C',
      email: 'levanc@example.com',
      borrowedBooks: [],
    ),
  ];

  void _addNewUser() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm người dùng mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                setState(() {
                  _users.add(UserModel(
                    id: _users.length + 1,
                    name: nameController.text,
                    email: emailController.text,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        user.name.substring(0, 1),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        const SizedBox(height: 4),
                        Text(
                          'Sách đã mượn: ${user.borrowedBooks.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        // Show user details
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(user.name),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${user.email}'),
                                const SizedBox(height: 10),
                                const Text(
                                  'Sách đã mượn:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                user.borrowedBooks.isEmpty
                                    ? const Text('Chưa mượn sách nào')
                                    : Column(
                                  children: user.borrowedBooks
                                      .map((book) => ListTile(
                                    title: Text(book.title),
                                    subtitle: Text(book.author),
                                    dense: true,
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewUser,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

// Borrow Book Page
class BorrowBookPage extends StatefulWidget {
  const BorrowBookPage({super.key});

  @override
  State<BorrowBookPage> createState() => _BorrowBookPageState();
}

class _BorrowBookPageState extends State<BorrowBookPage> {
  final List<UserModel> _users = [
    UserModel(
      id: 1,
      name: 'Nguyễn Văn A',
      email: 'nguyenvana@example.com',
    ),
    UserModel(
      id: 2,
      name: 'Trần Thị B',
      email: 'tranthib@example.com',
    ),
    UserModel(
      id: 3,
      name: 'Lê Văn C',
      email: 'levanc@example.com',
    ),
  ];

  UserModel? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mượn sách'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chọn người mượn:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<UserModel>(
                value: _selectedUser,
                hint: const Text('Chọn người dùng'),
                isExpanded: true,
                underline: const SizedBox(),
                onChanged: (UserModel? newValue) {
                  setState(() {
                    _selectedUser = newValue;
                  });
                },
                items: _users.map<DropdownMenuItem<UserModel>>((UserModel user) {
                  return DropdownMenuItem<UserModel>(
                    value: user,
                    child: Text(user.name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Thông tin sách được chọn:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // This would display the selected books from the previous page
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: ListView(
                  children: const [
                    BookInfoTile(
                      title: 'Sách 01',
                      author: 'Tác giả A',
                      isAvailable: true,
                    ),
                    SizedBox(height: 10),
                    BookInfoTile(
                      title: 'Sách 03',
                      author: 'Tác giả C',
                      isAvailable: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedUser == null
                    ? null
                    : () {
                  // Process borrowing
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${_selectedUser!.name} đã mượn sách thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text('Xác nhận mượn sách'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInfoTile extends StatelessWidget {
  final String title;
  final String author;
  final bool isAvailable;

  const BookInfoTile({
    super.key,
    required this.title,
    required this.author,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text('Tác giả: $author'),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Trạng thái: ',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                isAvailable ? 'Có sẵn' : 'Đã mượn',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}