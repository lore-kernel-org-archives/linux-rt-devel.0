Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795D3161B3
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112938; cv=pass; b=j08nopyFUYywzRO5RuLBq8onUVru8NIMxR/uDU0mYVh673yVjKuwmW81D3zg51RnzYM2SDO2/hCw6wgubvDenDP7369P3ZClbA+1jZ0+O8bT06AsjFKCMRUfYPdGu8XYe/z45o+jpqbvMATaHZPueO2/EKFkpHXXW8feMKgDCJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112938; c=relaxed/simple;
	bh=WnFPLxO9z9DSA3LvNZXmoul794WKeF+w+VqZE0CA+y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYafmV/N7ofmrtPVksvTzDxwGg17xjM/gokRQ3M0HBFugR7c4ONz/31n6cImY5v/DDI1GW4E1H5ru0BU1U4SCZTA2bIqgVabzOiFCtceja5i2mH0VO6LGAbUFldy1qOJuev7T4p17ebh2x1WnmCr7zlkNtCmaM+1OoZ3GTtqWuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I34QNXim; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I34QNXim"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014acad6f2so88261cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 12:15:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112932; cv=none;
        d=google.com; s=arc-20240605;
        b=Iiy5o3zuxwyZnISb9XtCJonszdpZ/iWGUkh0IxdIeQORg0lzOqwrMtw9f4RkLIbnq8
         cd9MMese61WCSZiFW+tmdrwhGG7B9ENCaTFfh54TUH1JH3dzSSRVTgsM3QTzznfqJrqh
         /8UXa5xd4rZRH/qks+4L4/qOSx/88kneCQ5Vorv8D4ETrkobH7PZW7BEs2Lnr7Hsk/uf
         PokMWreHyFBWfQQZFoi33/PoAwwdvE0oqvqRCj9Dzsh61jIsPtIslZm5W7QqwNokAEvD
         /sQQcCkUew8qZmw7x4TJ89Xfe7VBrTTe+5nNYINAVJv4fakdOwuwe0pYJJF5T9EOU7Vu
         Sv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XILBP281+8VrtpYosDEw7u/sNJAjO21IYZ4LAU+0xJA=;
        fh=o+2/QoPMAcnYT6aHVN15w9oOTK3FY3SwVZ1YZSTCD9o=;
        b=TJ8YBmo6Q28BzEJ/rKeP3456gMVOQhLrcfkmHbClw8oazbApI80RA1fYpPAvubcqLS
         5d8Zgx9pXQ4NJVhTAj9shJgDWw7kC9DuqGCKsu8++XRtDje4jA/Eb8+VC5xix5EUa0pe
         NwFIziRYI7yFGiNa0VtKeyB+JDs2k3D9G8JVMQB6Yb8R2sP5YT8WrESnf6w01ACpOq+Z
         ovOuhVjjagSXs+fQj4Dt5Bjc8fX7FdiskdBcjM/yrz1Ba6tLN8b08viT03Sx/lMyWoI5
         BwXSl0HWlfksFtYlh7gb7wpW5fMZXHRhY2kRMaV7MNSqnbVTEgsQPx/CEH/clJK44vyu
         o4Bw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769112932; x=1769717732; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XILBP281+8VrtpYosDEw7u/sNJAjO21IYZ4LAU+0xJA=;
        b=I34QNXimdZcq/hoXtGQfSeTOP81ytlpbYfkov/KBzQRMFQTqazOf/6o86XM/3XmKy+
         tIB4xqU8739PNMVliLrmmkauPG46595dQozkZ9pY2VukztFZozMv/CIicVtYrxuMFT6e
         CbxFKq7M1V81hAnBd7ZGKdloMNAeT9yZ9dGd1NHe/82+R2QjCmF5kbjTgIzWVfE53kzp
         a4ja4SC2kwiJbe79n5jeT6rpBfJrwSBLUkRuAepfJSFMzrRd9Hwggv41DjazTIrPKUiD
         XObEDU1vy5wbRejfeTQYNRhbQt8MvU10F1H9FNaeTSkP76Q5bwhyuYoGprlcY4E5nKkk
         WdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112932; x=1769717732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XILBP281+8VrtpYosDEw7u/sNJAjO21IYZ4LAU+0xJA=;
        b=ijHc9rgYSrhg4MTpw+Utn75WE1ge5ZE04savajgqyRO6g+UlrrUHbi00u/7MG5y5XH
         28kL4ZGyhzoIq/lBSeddwXFNJ48TljqFdRjJQ4ZTRM2KvbcFSdbgMufuIHf3G19CdgUR
         CGAqcrnuVexK9Jr560E88/db4vRd3ZZqYCoAwSkxOzMLL4Fv0EN7IA8ZNU99f9veg9Me
         d7da0k2B52xBnyw7EJBOnZjDNK3TnL0Zb4RzQOKksM4II1tDKjGyDVSlLkdSrqQjgyfh
         D1vz3k5XnNi3sbm3jRUAoeT2rpnaY8kqnG5i086VuN4oLXLDBNrHZ1YuKWDnu0t1OJjy
         AmqA==
X-Forwarded-Encrypted: i=1; AJvYcCVa+1jjDkDFEo/LiW4gJBEhkug5LIDk/juTOyi/Es0KjM/D9WtXLCC1h91bQuKZPIvmQq+3XE0BWmGRIBtAMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPfm3XYHTSTQVXI+cbYZmGLEdMFLiEj3hUTZE35qB9V+tucnwD
	0w9Tb4/fWrdEUg6FqpWza9jNQSC510Zw1VsRUYFJJy73Yehq4KOFQXPi1/s/AJZUMMlYuAJM6jo
	hVMoZsanKRXL71VgB9LH+DP4RbA1ht8tGypx/oPwY
X-Gm-Gg: AZuq6aKug0ycO54CMwE36EUjOqdkNTW8Y6ckP6kJcDUB4g/vf3OPkCZ2DzKapbc+ICu
	IyzCaPtmCnTubOO6aB2sd/6GhyOu/lzNwa1tAA9Y7WfBlOytSObHF9aoqa1YF1hNyoZD2bfwwj5
	ACCXG77WQX/FaqLJDp7cU4qctUz0GzTvaYuKXitDY1XLZ2JmHqh+NUgnuVUuiG/90uis8I/sjSG
	srgrGhCGnOem8o1VSp5ioXUxvWUhLB/hvivPM+lj0lcVFFG38Py2yaM9N7UJT0aFaTGHTmOpf0c
	mAhirWXGSsZRcJcuEQ4ug+nR
X-Received: by 2002:a05:622a:14:b0:4f1:9c6e:cf1c with SMTP id
 d75a77b69052e-502f8126e6fmr2006421cf.17.1769112931268; Thu, 22 Jan 2026
 12:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 12:15:20 -0800
X-Gm-Features: AZwV_QgoVz99OaZODU1LJm3Q2LqzAZioiBIEcwIIEUVcYXUXyt7rkbO5PzhYImU
Message-ID: <CAJuCfpFFW_tcHPMtryoVcSKigEGZxfn3Bz=8BUtrJj8kgEWDJA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] mm/vma: clean up __vma_enter/exit_locked()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 5:02=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> These functions are very confusing indeed. 'Entering' a lock could be
> interpreted as acquiring it, but this is not what these functions are
> interacting with.
>
> Equally they don't indicate at all what kind of lock we are 'entering' or
> 'exiting'. Finally they are misleading as we invoke these functions when =
we
> already hold a write lock to detach a VMA.
>
> These functions are explicitly simply 'entering' and 'exiting' a state in
> which we hold the EXCLUSIVE lock in order that we can either mark the VMA
> as being write-locked, or mark the VMA detached.
>
> Rename the functions accordingly, and also update
> __vma_exit_exclusive_locked() to return detached state with a __must_chec=
k
> directive, as it is simply clumsy to pass an output pointer here to
> detached state and inconsistent vs. __vma_enter_exclusive_locked().
>
> Finally, remove the unnecessary 'inline' directives.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mmap_lock.h |  4 +--
>  mm/mmap_lock.c            | 60 +++++++++++++++++++++++++--------------
>  2 files changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index da63b1be6ec0..873bc5f3c97c 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -209,8 +209,8 @@ static inline void vma_refcount_put(struct vm_area_st=
ruct *vma)
>         __vma_lockdep_release_read(vma);
>         detached =3D __vma_refcount_put(vma, &refcnt);
>         /*
> -        * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> -        * their reference count, so wake it up if we were the last reade=
r
> +        * __vma_enter_exclusive_locked() may be sleeping waiting for rea=
ders to
> +        * drop their reference count, so wake it up if we were the last =
reader
>          * blocking it from being acquired.
>          */
>         if (!detached && are_readers_excluded(refcnt))
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 7a0361cff6db..f73221174a8b 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -46,19 +46,43 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_PER_VMA_LOCK
>
> -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *d=
etached)
> +/*
> + * Now that all readers have been evicted, mark the VMA as being out of =
the
> + * 'exclude readers' state.
> + *
> + * Returns true if the VMA is now detached, otherwise false.
> + */
> +static bool __must_check __vma_exit_exclusive_locked(struct vm_area_stru=
ct *vma)
>  {
> -       *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
> -                                         &vma->vm_refcnt);
> +       bool detached;
> +
> +       detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG=
,
> +                                        &vma->vm_refcnt);
>         __vma_lockdep_release_exclusive(vma);
> +       return detached;
>  }
>
>  /*
> - * __vma_enter_locked() returns 0 immediately if the vma is not
> - * attached, otherwise it waits for any current readers to finish and
> - * returns 1.  Returns -EINTR if a signal is received while waiting.
> + * Mark the VMA as being in a state of excluding readers, check to see i=
f any
> + * VMA read locks are indeed held, and if so wait for them to be release=
d.
> + *
> + * Note that this function pairs with vma_refcount_put() which will wake=
 up this
> + * thread when it detects that the last reader has released its lock.
> + *
> + * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in cases =
where we
> + * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fatal =
signal
> + * is permitted to kill it.
> + *
> + * The function will return 0 immediately if the VMA is detached, and 1 =
once the
> + * VMA has evicted all readers, leaving the VMA exclusively locked.

The wording here is a bit misleading. We do not evict the readers,
just wait for them to complete and exit.

> + *
> + * If the function returns 1, the caller is required to invoke
> + * __vma_exit_exclusive_locked() once the exclusive state is no longer r=
equired.
> + *
> + * If state is set to something other than TASK_UNINTERRUPTIBLE, the fun=
ction
> + * may also return -EINTR to indicate a fatal signal was received while =
waiting.
>   */
> -static inline int __vma_enter_locked(struct vm_area_struct *vma,
> +static int __vma_enter_exclusive_locked(struct vm_area_struct *vma,
>                 bool detaching, int state)
>  {
>         int err;
> @@ -85,13 +109,10 @@ static inline int __vma_enter_locked(struct vm_area_=
struct *vma,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
>                    state);
>         if (err) {
> -               bool detached;
> -
> -               __vma_exit_locked(vma, &detached);
> -               if (detached) {
> +               if (__vma_exit_exclusive_locked(vma)) {
>                         /*
>                          * The wait failed, but the last reader went away
> -                        * as well.  Tell the caller the VMA is detached.
> +                        * as well. Tell the caller the VMA is detached.
>                          */
>                         WARN_ON_ONCE(!detaching);
>                         err =3D 0;
> @@ -108,7 +129,7 @@ int __vma_start_write(struct vm_area_struct *vma, uns=
igned int mm_lock_seq,
>  {
>         int locked;
>
> -       locked =3D __vma_enter_locked(vma, false, state);
> +       locked =3D __vma_enter_exclusive_locked(vma, false, state);
>         if (locked < 0)
>                 return locked;
>
> @@ -120,12 +141,9 @@ int __vma_start_write(struct vm_area_struct *vma, un=
signed int mm_lock_seq,
>          */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>
> -       if (locked) {
> -               bool detached;
> -
> -               __vma_exit_locked(vma, &detached);
> -               WARN_ON_ONCE(detached); /* vma should remain attached */
> -       }
> +       /* vma should remain attached. */
> +       if (locked)
> +               WARN_ON_ONCE(__vma_exit_exclusive_locked(vma));

I'm wary of calling functions from WARN_ON_ONCE() statements. If
someone decides to replace WARN_ON_ONCE() with VM_WARN_ON_ONCE(), the
call will disappear when CONFIG_DEBUG_VM=3Dn. Maybe I'm being paranoid
but it's because I have been bitten by that before...

>
>         return 0;
>  }
> @@ -145,12 +163,12 @@ void vma_mark_detached(struct vm_area_struct *vma)
>         detached =3D __vma_refcount_put(vma, NULL);
>         if (unlikely(!detached)) {
>                 /* Wait until vma is detached with no readers. */
> -               if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) =
{
> +               if (__vma_enter_exclusive_locked(vma, true, TASK_UNINTERR=
UPTIBLE)) {
>                         /*
>                          * Once this is complete, no readers can incremen=
t the
>                          * reference count, and the VMA is marked detache=
d.
>                          */
> -                       __vma_exit_locked(vma, &detached);
> +                       detached =3D __vma_exit_exclusive_locked(vma);
>                         WARN_ON_ONCE(!detached);
>                 }
>         }
> --
> 2.52.0
>
