Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C32777EA;
	Fri, 23 Jan 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208533; cv=none; b=FYKPBgiCPrYiJ3SLOqCF7sMrBih27cyr8v0d9OeJP2WhmcPdbIJe4yEsnbmWlQvDNlrlf3ORjYY5/NacOL2+EDB+yc9sm7XzVWsav6KZf0AfimASzVeojD9DP5E20k51L6ygsv+Uaag4uOEM43WUdbD6EiOsYMXtY0bs6L2a7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208533; c=relaxed/simple;
	bh=wxD197rE+/TtE4bXLv/ENQIJmjflr7nik+q61gsCPG0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XG3Hjtb+npoJg2wdP3oD92XtUGtXQ4eclUr2pust8e9rv3PTyyRwx33kiCX2jH/fYNljirNFhPhrcpbzbsT/fZo33trsnZKbhkxGEoIpUYuYA1c7ba+gpZe08d+Zq9aGAPMv/dgsrqZN/rB571fPW+Cqyp5o+h5yla1hNnUh/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IH9n5yfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IH9n5yfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2ABC4CEF1;
	Fri, 23 Jan 2026 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769208532;
	bh=wxD197rE+/TtE4bXLv/ENQIJmjflr7nik+q61gsCPG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IH9n5yfh1fh9c9KcsyWH/K4sWn/rfIoMa/QRgWK/5yCA84jcQhQCW0rvOsQnWO5OM
	 7uuiemeF9bavSPx/6jEmax2D8LN72iocnE9vcbXOH2UclURVW/osuxLldFHLvkUCxr
	 7wQQtHIuTkO8KwSHV5p3eNH/tscmFB+TFxGNfOeQ=
Date: Fri, 23 Jan 2026 14:48:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 00/10] mm: add and use vma_assert_stabilised() helper
Message-Id: <20260123144851.f752d80db3c8f700df31aa84@linux-foundation.org>
In-Reply-To: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 20:12:10 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> This series first introduces a series of refactorings, intended to
> significantly improve readability and abstraction of the code.

I updated the mm-unstable branch with this, thanks.

> v4:
> * Propagated tags (thanks Vlastimil, Suren!)
> * Updated reference count documentation in 2/10 as per Vlastimil, Suren.
> * Updated 7/10 to update the references in the reference count comment from
>   __vma_exit_locked() to __vma_end_exclude_readers().
> * Renamed are_readers_excluded() to __vma_are_readers_excluded() as per
>   Vlastimil.
> * Several more comment updates as per Vlastimil, Suren in 3/10.
> * Updated 3/10 commit message as per Suren.
> * Updated __vma_refcount_put() to just return the newcnt as per Suren.
> * Renamed __vma_refcount_put() to __vma_refcount_put_return() as per Vlastimil.
> * Made __vma_refcount_put_return() __must_check too.
> * Comment fixups on 4/10 as per Vlastimil.
> * Renamed __vma_enter_exclusive_locked() and __vma_exit_exclusive_locked()
>   to __vma_start_exclude_readers() and __vma_end_exclude_readers() as per
>   Vlastimil in 6/10.
> * Reworked comment as per Suren in 6/10.
> * Avoided WARN_ON_ONCE() function invocation as per Suren in 6/10.
> * s/ves->locked/ves->exclusive/ as per Suren in 7/10.
> * Removed confusing asserts in 7/10 as per Suren.
> * Changed from !ves.detached to ves.exclusive in 7/10 as per Suren.
> * Updated comments in 7/10 as per Suren.
> * Removed broken assert in __vma_end_exclude_readers() in 7/10 as per
>   Vlastimil.
> * Separated out vma_mark_detached() into static inline portion and unlikely
>   exclude readers in 7/10 as per Vlastimil.
> * Removed mm seq num output parameter from __is_vma_write_locked() as per
>   Vlastimil in 8/10.
> * Converted VM_BUG_ON_VMA() to VM_WARN_ON_ONCE() in 8/10 as per Vlastimil
>   (though he said it in reply to a future commit :).
> * Added helper function __vma_raw_mm_seqnum() to aid the conversion of
>   __is_vma_write_locked() and updated the commit message accordingly.
> * Moved mmap_assert_write_locked() to __vma_raw_mm_seqnum() is it is
>   required for this access to be valid.
> * Replaced VM_BUG_ON_VMA() with VM_WARN_ON_ONCE_VMA() on 9/10 as per
>   Vlastiml.
> * Renamed refs to refcnt in vma_assert_locked() to be consistent.
> * Moved comment about reference count possible values above refcnt
>   assignment so it's not just weirdly at the top of the function.

Below is how v4 altered mm.git:


--- a/include/linux/mmap_lock.h~b
+++ a/include/linux/mmap_lock.h
@@ -87,10 +87,11 @@ static inline void mmap_assert_write_loc
  *
  * Write locks are acquired exclusively per-VMA, but released in a shared
  * fashion, that is upon vma_end_write_all(), we update the mmap's seqcount such
- * that write lock is de-acquired.
+ * that write lock is released.
  *
  * We therefore cannot track write locks per-VMA, nor do we try. Mitigating this
- * is the fact that, of course, we do lockdep-track the mmap lock rwsem.
+ * is the fact that, of course, we do lockdep-track the mmap lock rwsem which
+ * must be held when taking a VMA write lock.
  *
  * We do, however, want to indicate that during either acquisition of a VMA
  * write lock or detachment of a VMA that we require the lock held be exclusive,
@@ -152,14 +153,9 @@ static inline void vma_lock_init(struct
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-/**
- * are_readers_excluded() - Determine whether @refcnt describes a VMA which has
- * excluded all VMA read locks.
- * @refcnt: The VMA reference count obtained from vm_area_struct->vm_refcnt.
- *
- * We may be raced by other readers temporarily incrementing the reference
- * count, though the race window is very small, this might cause spurious
- * wakeups.
+/*
+ * This function determines whether the input VMA reference count describes a
+ * VMA which has excluded all VMA read locks.
  *
  * In the case of a detached VMA, we may incorrectly indicate that readers are
  * excluded when one remains, because in that scenario we target a refcount of
@@ -170,7 +166,7 @@ static inline void vma_lock_init(struct
  *
  * Returns: true if readers are excluded, false otherwise.
  */
-static inline bool are_readers_excluded(int refcnt)
+static inline bool __vma_are_readers_excluded(int refcnt)
 {
 	/*
 	 * See the comment describing the vm_area_struct->vm_refcnt field for
@@ -180,15 +176,21 @@ static inline bool are_readers_excluded(
 		refcnt <= VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
 }
 
-static inline bool __vma_refcount_put(struct vm_area_struct *vma, int *refcnt)
+/*
+ * Actually decrement the VMA reference count.
+ *
+ * The function returns the reference count as it was immediately after the
+ * decrement took place. If it returns zero, the VMA is now detached.
+ */
+static inline __must_check unsigned int
+__vma_refcount_put_return(struct vm_area_struct *vma)
 {
 	int oldcnt;
-	bool detached;
 
-	detached = __refcount_dec_and_test(&vma->vm_refcnt, &oldcnt);
-	if (refcnt)
-		*refcnt = oldcnt - 1;
-	return detached;
+	if (__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt))
+		return 0;
+
+	return oldcnt - 1;
 }
 
 /**
@@ -203,17 +205,21 @@ static inline void vma_refcount_put(stru
 {
 	/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt. */
 	struct mm_struct *mm = vma->vm_mm;
-	int refcnt;
-	bool detached;
+	int newcnt;
 
 	__vma_lockdep_release_read(vma);
-	detached = __vma_refcount_put(vma, &refcnt);
+	newcnt = __vma_refcount_put_return(vma);
+
 	/*
-	 * __vma_enter_exclusive_locked() may be sleeping waiting for readers to
+	 * __vma_start_exclude_readers() may be sleeping waiting for readers to
 	 * drop their reference count, so wake it up if we were the last reader
 	 * blocking it from being acquired.
+	 *
+	 * We may be raced by other readers temporarily incrementing the
+	 * reference count, though the race window is very small, this might
+	 * cause spurious wakeups.
 	 */
-	if (!detached && are_readers_excluded(refcnt))
+	if (newcnt && __vma_are_readers_excluded(newcnt))
 		rcuwait_wake_up(&mm->vma_writer_wait);
 }
 
@@ -252,6 +258,15 @@ static inline void vma_end_read(struct v
 	vma_refcount_put(vma);
 }
 
+static inline unsigned int __vma_raw_mm_seqnum(struct vm_area_struct *vma)
+{
+	const struct mm_struct *mm = vma->vm_mm;
+
+	/* We must hold an exclusive write lock for this access to be valid. */
+	mmap_assert_write_locked(vma->vm_mm);
+	return mm->mm_lock_seq.sequence;
+}
+
 /*
  * Determine whether a VMA is write-locked. Must be invoked ONLY if the mmap
  * write lock is held.
@@ -260,22 +275,13 @@ static inline void vma_end_read(struct v
  *
  * Note that mm_lock_seq is updated only if the VMA is NOT write-locked.
  */
-static inline bool __is_vma_write_locked(struct vm_area_struct *vma,
-					 unsigned int *mm_lock_seq)
+static inline bool __is_vma_write_locked(struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	const unsigned int seq = mm->mm_lock_seq.sequence;
-
-	mmap_assert_write_locked(mm);
-
 	/*
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	if (vma->vm_lock_seq == seq)
-		return true;
-	*mm_lock_seq = seq;
-	return false;
+	return vma->vm_lock_seq == __vma_raw_mm_seqnum(vma);
 }
 
 int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
@@ -288,12 +294,10 @@ int __vma_start_write(struct vm_area_str
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	unsigned int mm_lock_seq;
-
-	if (__is_vma_write_locked(vma, &mm_lock_seq))
+	if (__is_vma_write_locked(vma))
 		return;
 
-	__vma_start_write(vma, mm_lock_seq, TASK_UNINTERRUPTIBLE);
+	__vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_UNINTERRUPTIBLE);
 }
 
 /**
@@ -312,11 +316,10 @@ static inline void vma_start_write(struc
 static inline __must_check
 int vma_start_write_killable(struct vm_area_struct *vma)
 {
-	unsigned int mm_lock_seq;
-
-	if (__is_vma_write_locked(vma, &mm_lock_seq))
+	if (__is_vma_write_locked(vma))
 		return 0;
-	return __vma_start_write(vma, mm_lock_seq, TASK_KILLABLE);
+
+	return __vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_KILLABLE);
 }
 
 /**
@@ -325,9 +328,7 @@ int vma_start_write_killable(struct vm_a
  */
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	unsigned int mm_lock_seq;
-
-	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
+	VM_WARN_ON_ONCE_VMA(!__is_vma_write_locked(vma), vma);
 }
 
 /**
@@ -337,12 +338,7 @@ static inline void vma_assert_write_lock
  */
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	unsigned int refs;
-
-	/*
-	 * See the comment describing the vm_area_struct->vm_refcnt field for
-	 * details of possible refcnt values.
-	 */
+	unsigned int refcnt;
 
 	/*
 	 * If read-locked or currently excluding readers, then the VMA is
@@ -353,18 +349,22 @@ static inline void vma_assert_locked(str
 		return;
 #endif
 
-	refs = refcount_read(&vma->vm_refcnt);
+	/*
+	 * See the comment describing the vm_area_struct->vm_refcnt field for
+	 * details of possible refcnt values.
+	 */
+	refcnt = refcount_read(&vma->vm_refcnt);
 
 	/*
 	 * In this case we're either read-locked, write-locked with temporary
 	 * readers, or in the midst of excluding readers, all of which means
 	 * we're locked.
 	 */
-	if (refs > 1)
+	if (refcnt > 1)
 		return;
 
 	/* It is a bug for the VMA to be detached here. */
-	VM_BUG_ON_VMA(!refs, vma);
+	VM_WARN_ON_ONCE_VMA(!refcnt, vma);
 
 	/*
 	 * OK, the VMA has a reference count of 1 which means it is either
@@ -447,7 +447,28 @@ static inline void vma_mark_attached(str
 	refcount_set_release(&vma->vm_refcnt, 1);
 }
 
-void vma_mark_detached(struct vm_area_struct *vma);
+void __vma_exclude_readers_for_detach(struct vm_area_struct *vma);
+
+static inline void vma_mark_detached(struct vm_area_struct *vma)
+{
+	vma_assert_write_locked(vma);
+	vma_assert_attached(vma);
+
+	/*
+	 * The VMA still being attached (refcnt > 0) - is unlikely, because the
+	 * vma has been already write-locked and readers can increment vm_refcnt
+	 * only temporarily before they check vm_lock_seq, realize the vma is
+	 * locked and drop back the vm_refcnt. That is a narrow window for
+	 * observing a raised vm_refcnt.
+	 *
+	 * See the comment describing the vm_area_struct->vm_refcnt field for
+	 * details of possible refcnt values.
+	 */
+	if (likely(!__vma_refcount_put_return(vma)))
+		return;
+
+	__vma_exclude_readers_for_detach(vma);
+}
 
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
--- a/include/linux/mm_types.h~b
+++ a/include/linux/mm_types.h
@@ -753,7 +753,7 @@ static inline struct anon_vma_name *anon
 #endif
 
 /*
- * WHile __vma_enter_locked() is working to ensure are no read-locks held on a
+ * While __vma_enter_locked() is working to ensure are no read-locks held on a
  * VMA (either while acquiring a VMA write lock or marking a VMA detached) we
  * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indiciate to
  * vma_start_read() that the reference count should be left alone.
@@ -991,16 +991,19 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_PER_VMA_LOCK
 	/*
-	 * Used to keep track of the number of references taken by VMA read or
-	 * write locks. May have the VM_REFCNT_EXCLUDE_READERS_FLAG set
-	 * indicating that a thread has entered __vma_enter_locked() and is
-	 * waiting on any outstanding read locks to exit.
+	 * Used to keep track of firstly, whether the VMA is attached, secondly,
+	 * if attached, how many read locks are taken, and thirdly, if the
+	 * VM_REFCNT_EXCLUDE_READERS_FLAG is set, whether any read locks held
+	 * are currently in the process of being excluded.
 	 *
 	 * This value can be equal to:
 	 *
-	 * 0 - Detached.
+	 * 0 - Detached. IMPORTANT: when the refcnt is zero, readers cannot
+	 * increment it.
 	 *
-	 * 1 - Unlocked or write-locked.
+	 * 1 - Attached and either unlocked or write-locked. Write locks are
+	 * identified via __is_vma_write_locked() which checks for equality of
+	 * vma->vm_lock_seq and mm->mm_lock_seq.
 	 *
 	 * >1, < VM_REFCNT_EXCLUDE_READERS_FLAG - Read-locked or (unlikely)
 	 * write-locked with other threads having temporarily incremented the
@@ -1008,19 +1011,19 @@ struct vm_area_struct {
 	 * decrementing it again.
 	 *
 	 * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
-	 * __vma_exit_locked() completion which will decrement the reference
-	 * count to zero. IMPORTANT - at this stage no further readers can
-	 * increment the reference count. It can only be reduced.
-	 *
-	 * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - Either an attached VMA pending
-	 * __vma_exit_locked() completion which will decrement the reference
-	 * count to one, OR a detached VMA waiting on a single spurious reader
-	 * to decrement reference count. IMPORTANT - as above, no further
-	 * readers can increment the reference count.
-	 *
-	 * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - VMA is waiting on readers,
-	 * whether it is attempting to acquire a write lock or attempting to
-	 * detach. IMPORTANT - as above, no ruther readers can increment the
+	 * __vma_exit_exclusive_locked() completion which will decrement the
+	 * reference count to zero. IMPORTANT - at this stage no further readers
+	 * can increment the reference count. It can only be reduced.
+	 *
+	 * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either write-locking
+	 * an attached VMA and has yet to invoke __vma_exit_exclusive_locked(),
+	 * OR a thread is detaching a VMA and is waiting on a single spurious
+	 * reader in order to decrement the reference count. IMPORTANT - as
+	 * above, no further readers can increment the reference count.
+	 *
+	 * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either
+	 * write-locking or detaching a VMA is waiting on readers to
+	 * exit. IMPORTANT - as above, no ruther readers can increment the
 	 * reference count.
 	 *
 	 * NOTE: Unstable RCU readers are allowed to read this.
--- a/mm/mmap_lock.c~b
+++ a/mm/mmap_lock.c
@@ -53,6 +53,7 @@ struct vma_exclude_readers_state {
 	int state; /* TASK_KILLABLE or TASK_UNINTERRUPTIBLE. */
 	bool detaching;
 
+	/* Output parameters. */
 	bool detached;
 	bool exclusive; /* Are we exclusively locked? */
 };
@@ -60,15 +61,12 @@ struct vma_exclude_readers_state {
 /*
  * Now that all readers have been evicted, mark the VMA as being out of the
  * 'exclude readers' state.
- *
- * Returns true if the VMA is now detached, otherwise false.
  */
-static void __vma_exit_exclusive_locked(struct vma_exclude_readers_state *ves)
+static void __vma_end_exclude_readers(struct vma_exclude_readers_state *ves)
 {
 	struct vm_area_struct *vma = ves->vma;
 
 	VM_WARN_ON_ONCE(ves->detached);
-	VM_WARN_ON_ONCE(!ves->exclusive);
 
 	ves->detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
 					      &vma->vm_refcnt);
@@ -93,27 +91,24 @@ static unsigned int get_target_refcnt(st
  * where we wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fatal
  * signal is permitted to kill it.
  *
- * The function sets the ves->locked parameter to true if an exclusive lock was
- * acquired, or false if the VMA was detached or an error arose on wait.
+ * The function sets the ves->exclusive parameter to true if readers were
+ * excluded, or false if the VMA was detached or an error arose on wait.
  *
  * If the function indicates an exclusive lock was acquired via ves->exclusive
- * (or equivalently, returning 0 with !ves->detached), the caller is required to
- * invoke __vma_exit_exclusive_locked() once the exclusive state is no longer
- * required.
+ * the caller is required to invoke __vma_end_exclude_readers() once the
+ * exclusive state is no longer required.
  *
  * If ves->state is set to something other than TASK_UNINTERRUPTIBLE, the
  * function may also return -EINTR to indicate a fatal signal was received while
  * waiting.
  */
-static int __vma_enter_exclusive_locked(struct vma_exclude_readers_state *ves)
+static int __vma_start_exclude_readers(struct vma_exclude_readers_state *ves)
 {
 	struct vm_area_struct *vma = ves->vma;
 	unsigned int tgt_refcnt = get_target_refcnt(ves);
 	int err = 0;
 
 	mmap_assert_write_locked(vma->vm_mm);
-	VM_WARN_ON_ONCE(ves->detached);
-	VM_WARN_ON_ONCE(ves->exclusive);
 
 	/*
 	 * If vma is detached then only vma_mark_attached() can raise the
@@ -132,7 +127,7 @@ static int __vma_enter_exclusive_locked(
 		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
 		   ves->state);
 	if (err) {
-		__vma_exit_exclusive_locked(ves);
+		__vma_end_exclude_readers(ves);
 		return err;
 	}
 
@@ -150,7 +145,7 @@ int __vma_start_write(struct vm_area_str
 		.state = state,
 	};
 
-	err = __vma_enter_exclusive_locked(&ves);
+	err = __vma_start_exclude_readers(&ves);
 	if (err) {
 		WARN_ON_ONCE(ves.detached);
 		return err;
@@ -164,8 +159,8 @@ int __vma_start_write(struct vm_area_str
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
 
-	if (!ves.detached) {
-		__vma_exit_exclusive_locked(&ves);
+	if (ves.exclusive) {
+		__vma_end_exclude_readers(&ves);
 		/* VMA should remain attached. */
 		WARN_ON_ONCE(ves.detached);
 	}
@@ -174,7 +169,7 @@ int __vma_start_write(struct vm_area_str
 }
 EXPORT_SYMBOL_GPL(__vma_start_write);
 
-void vma_mark_detached(struct vm_area_struct *vma)
+void __vma_exclude_readers_for_detach(struct vm_area_struct *vma)
 {
 	struct vma_exclude_readers_state ves = {
 		.vma = vma,
@@ -183,16 +178,6 @@ void vma_mark_detached(struct vm_area_st
 	};
 	int err;
 
-	vma_assert_write_locked(vma);
-	vma_assert_attached(vma);
-
-	/*
-	 * See the comment describing the vm_area_struct->vm_refcnt field for
-	 * details of possible refcnt values.
-	 */
-	if (likely(__vma_refcount_put(vma, NULL)))
-		return;
-
 	/*
 	 * Wait until the VMA is detached with no readers. Since we hold the VMA
 	 * write lock, the only read locks that might be present are those from
@@ -200,13 +185,13 @@ void vma_mark_detached(struct vm_area_st
 	 * reference count before realising the write lock is held and
 	 * decrementing it.
 	 */
-	err = __vma_enter_exclusive_locked(&ves);
-	if (!err && !ves.detached) {
+	err = __vma_start_exclude_readers(&ves);
+	if (!err && ves.exclusive) {
 		/*
 		 * Once this is complete, no readers can increment the
 		 * reference count, and the VMA is marked detached.
 		 */
-		__vma_exit_exclusive_locked(&ves);
+		__vma_end_exclude_readers(&ves);
 	}
 	/* If an error arose but we were detached anyway, we don't care. */
 	WARN_ON_ONCE(!ves.detached);
_

