Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4522701B8;
	Mon, 26 Jan 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456287; cv=none; b=QKaS8XAhH0WS0d/EGcor8KQMT36nOfkq4kryccN8EJHxshleUAYGvg6Bu2aA4XVWz15huB0i8VxA+0zHd9ZTUeruRamPih+dpeDD6U0gHK5i9JVkkrRLe6cQXbwU6Ur6IWzZjy7AEIk8gK2kkYmG905neCwI1flkT0o89cU4FDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456287; c=relaxed/simple;
	bh=R9PbN9ntS2LDukuVYwI34djTXDghM47LTWOybDJ3vlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aF+jNGzIfeOnEAxVdCuCj/XcMSDqxHiyzGtuJ9n8D/4cjpZKnhhZ2hlwAWXHi5aoNELvlnyNPEB2XQYfFRQYPg621+nZYuxhkgB/wcqYcVn7q1VFClg3irME6WF36pxJSeVlilcNBXVi8VYrbkGq/9+YCSSGmX/83qyiygiFBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YkOaj0qE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YkOaj0qE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5B9C116C6;
	Mon, 26 Jan 2026 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769456287;
	bh=R9PbN9ntS2LDukuVYwI34djTXDghM47LTWOybDJ3vlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YkOaj0qEK+Bj67GnpQv4Jl03pawuX3A8+7L9FQ86c8qsWyl/hI7VAjvGfW9K61tLj
	 QzzneJTYBFhga2+e0+BUXvjQsxlT2WILRSNokESaiSJsDlcNWNcxm5XabjH5Yf+Al/
	 /HaCH5yeko51GgcUsOKs9LpWNrcQ0q1UKf725TYo=
Date: Mon, 26 Jan 2026 11:38:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
Message-Id: <20260126113806.5b0942a6fd0a3554ae5e21fd@linux-foundation.org>
In-Reply-To: <c09f2c10-516c-43b9-81a6-cc77e5f78ba8@lucifer.local>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
	<7d3084d596c84da10dd374130a5055deba6439c0.1769198904.git.lorenzo.stoakes@oracle.com>
	<ba27d41a-2109-4c89-83ce-00ba8b78d249@suse.cz>
	<c09f2c10-516c-43b9-81a6-cc77e5f78ba8@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 16:09:24 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Andrew - could we change the commit message to:
> 
> -->
> 
> It is confusing to have __vma_start_exclude_readers() return 0, 1 or an
> error (but only when waiting for readers in TASK_KILLABLE state), and
> having the return value be stored in a stack variable called 'locked' is
> further confusion.
> 
> More generally, we are doing a lot of rather finnicky things during the
> acquisition of a state in which readers are excluded and moving out of this
> state, including tracking whether we are detached or not or whether an
> error occurred.
> 
> We are implementing logic in __vma_start_exclude_readers() that effectively
> acts as if 'if one caller calls us do X, if another then do Y', which is
> very confusing from a control flow perspective.
> 
> Introducing the shared helper object state helps us avoid this, as we can
> now handle the 'an error arose but we're detached' condition correctly in
> both callers - a warning if not detaching, and treating the situation as if
> no error arose in the case of a VMA detaching.
> 
> This also acts to help document what's going on and allows us to add some
> more logical debug asserts.
> 
> Also update vma_mark_detached() to add a guard clause for the likely
> 'already detached' state (given we hold the mmap write lock), and add a
> comment about ephemeral VMA read lock reference count increments to clarify
> why we are entering/exiting an exclusive locked state here.
> 
> Finally, separate vma_mark_detached() into its fast-path component and make
> it inline, then place the slow path for excluding readers in mmap_lock.c.
> 
> No functional change intended.

Pasted in.

> <--
> 
> Please as per Vlasta's comments below? Thanks!
> 
> Also could you sed the patch with:
> 
> s/__vma_exit_exclusive_locked/__vma_end_exclude_readers/
> s/__vma_[enter, exit]_exclusive_locked/__vma_[start, end]_exclude_readers/
> 
> As per Vlasta's comments below?
>
> As I have clearly forgotten to do this bit myself... doh!
> 
> Also at the bottom there is one small correction to a comment there too.

I added this -fix:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-vma-introduce-helper-struct-thread-through-exclusive-lock-fns-fix
Date: Fri, 23 Jan 2026 20:12:17 +0000

fix function naming in comments, add comment per Vlastimil per Lorenzo

Link: https://lkml.kernel.org/r/7d3084d596c84da10dd374130a5055deba6439c0.1769198904.git.lorenzo.stoakes@oracle.com
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mm_types.h |    4 ++--
 mm/mmap_lock.c           |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/mm_types.h~mm-vma-introduce-helper-struct-thread-through-exclusive-lock-fns-fix
+++ a/include/linux/mm_types.h
@@ -1011,12 +1011,12 @@ struct vm_area_struct {
 	 * decrementing it again.
 	 *
 	 * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
-	 * __vma_exit_exclusive_locked() completion which will decrement the
+	 * __vma_end_exclude_readers() completion which will decrement the
 	 * reference count to zero. IMPORTANT - at this stage no further readers
 	 * can increment the reference count. It can only be reduced.
 	 *
 	 * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either write-locking
-	 * an attached VMA and has yet to invoke __vma_exit_exclusive_locked(),
+	 * an attached VMA and has yet to invoke __vma_end_exclude_readers(),
 	 * OR a thread is detaching a VMA and is waiting on a single spurious
 	 * reader in order to decrement the reference count. IMPORTANT - as
 	 * above, no further readers can increment the reference count.
--- a/mm/mmap_lock.c~mm-vma-introduce-helper-struct-thread-through-exclusive-lock-fns-fix
+++ a/mm/mmap_lock.c
@@ -46,7 +46,7 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_relea
 #ifdef CONFIG_MMU
 #ifdef CONFIG_PER_VMA_LOCK
 
-/* State shared across __vma_[enter, exit]_exclusive_locked(). */
+/* State shared across __vma_[start, end]_exclude_readers. */
 struct vma_exclude_readers_state {
 	/* Input parameters. */
 	struct vm_area_struct *vma;
@@ -100,7 +100,7 @@ static unsigned int get_target_refcnt(st
  *
  * If ves->state is set to something other than TASK_UNINTERRUPTIBLE, the
  * function may also return -EINTR to indicate a fatal signal was received while
- * waiting.
+ * waiting.  Otherwise, the function returns 0.
  */
 static int __vma_start_exclude_readers(struct vma_exclude_readers_state *ves)
 {
_

