.. mem_ptr_deref_null:

Null pointer dereference
========================

Dereferencing pointer with NULL value terminates an application.

Technical details
~~~~~~~~~~~~~~~~~
The issue comes from memory management unit (MMU) de-facto conventions. When such a memory access occurs, the operating system looks up the page in the page table. However, the address range of the page containing null address is historically not mapped to any page, leading to SIGSEGV signal (on POSIX systems).
