Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F32C21EA
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118127; cv=pass; b=CxyqX2FRWeyNKWCih80HvFJETrDf07BlBaAwsYaH00RsdLkbMrx38NHeoOTek8J6Nr6uDwiODlG5gNpj/MdIC2ST1eGXtZm44l0AwVPRDe9TyT7CW7Wd27L6IkeUrJGT2IVJDbKqXtIjmdclhY7FOYvkZr9tI3j9GgaopDdrUoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118127; c=relaxed/simple;
	bh=ldxyVyHxFhfnWgYZEiOhs8vgc1yCvvGRJIg/Q/VMGW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+hLdcDwNlYFJcjBxPelJ420daC+yORIFlTr+4gIUsMn8QKrAVSs4Zw6w+009eWtTMuKb/MQHZyB0cCfnwe5Nb1OLUuAVfQ4ATJUbfAW1zqSHPJCT/HMAgwbo/BkUwtODhZv/71SH/XvyOiwI5GE1m5IPXPfSphVIVQBqCnNtHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ky1K9xHc; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ky1K9xHc"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50299648ae9so51451cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 13:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118112; cv=none;
        d=google.com; s=arc-20240605;
        b=KcBydHlfI01I8uhfwNCcw6Dp5rFELWulj40wHulzdcnPlW24p3d1qrpt/Xh6As0aDP
         tmUitiKl5VYBnQkvpwvXg4wvY2BayFKKJsZLYwc0YgyLRZEOj85xfEg6xaIdqw9rgVHx
         j2/vLgp7ykFSz5uHmfYgrbij2Op++noosb0QHVIltbiSqEzvPJa0EcvdTZV7HdQpCok5
         syrDZmHh+qcYSMFBnxdG/3pLkASU80eSo+aX+rI54nlM9DP2kPdXSde/KU/aicIFAlm5
         iHa5WFJFCFjsulJUYjWXXojKfeu/qVDV5xmmTPe0b1A/ZoID0LiOzD+pVT1thhlt2oXV
         4uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0z36lq24n0t7CcQnsonx07kAaEuIJ+bjVsuvlPAw7g=;
        fh=9+h2+wJjBoohRcid9BIKsDUCrNTDWJRZ8kj/GHY0kHM=;
        b=Vlxd2giAzZ1vo6ptC3AAbCiRo1bXIMGt962FecTcltcFUmmgmG+vl2ZRb48Vx+HYmt
         KoGe0MJbnl0ERJs6BOSNi6b6/mniiTVEFufI4zRVXdVt3PzJUQ9p61hGchf1VV+kfBkJ
         YyzPMcZu+LugnD5pSSfjccq2QVPH8bqWtGcRBCZ04zeumoIOluwFxK/hfi4lRo6ILA59
         Ur5HH1pBbkdL8tofDUs9rrZ40JSzW/kPph8LZ5L1XOuwhGVdq2DwScYhjsAaZgylNhvS
         EBqLKR18TvIPQfwcpbO7Gxwtd46gAd6rSdYS7lZOQKLOQUc3uY9GgosgeaC2YlnnZRBa
         PJgg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769118111; x=1769722911; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0z36lq24n0t7CcQnsonx07kAaEuIJ+bjVsuvlPAw7g=;
        b=ky1K9xHcZ5tq5bxKggdU4wSwI8hRgzCxIj1hIAK0cznY8V6KBlvW+Lv4oMlD56GrKF
         QJTXo6ZPR2Pw+wYNO4kh3R1AuHgMEAnbnnMdNNyt6+DBV8um0KzuplqCQTqv0QUXEzsA
         3+UY249B0phkyzbQGv8ldgUCDiUDK06ojB/In5mPdgeA2GQpOmhqxXuuwIznP/1Ge3bd
         JBjvbP/V3sGkTZ7mCfA9exyr5eiyMjOdI2nfCEs0o/OOi9HDhHmHYvZrfc3J3/CyI9Wl
         SHJltsJhYss83avENmm7NNLG+UbEtDMs0n/A702Gd5VG7RUc5YGqQeSQEg1gaeCjQFvA
         /EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118112; x=1769722912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b0z36lq24n0t7CcQnsonx07kAaEuIJ+bjVsuvlPAw7g=;
        b=vddaAwzBZxWHKYDE100O1nXxCJ6mAmykLdywZ7w6Cd4S3iGK7QlKukrE2yitAJKpxz
         2Q+Q84+Hm3rptUE7B0eqvp6v82IQkYD422eLJRcgFe9BqBfRhTZQhs70yDrLsBwus9cn
         RzuAF/cDFumAOtLwCsL0X1D8e0HLbN7NvzbEnAApdNQSFMzci5R85Mu/YEIELa4wX8XB
         5EbqW6TawLKLAxtyN43XJFzLkd3ABDtwW3ucuc4cnRNnW34PbAP6qEM2mcd/whmDhGSL
         b99THTML5v6LxyK4qOEc6bTLg2wf2A1vgiGuL6jYTBMDOMU+VqCMAO9mdxnPXY45v2pn
         mZrw==
X-Forwarded-Encrypted: i=1; AJvYcCVwBirJadrx4Lcughh1qm8w5w06gP1f2rpjWJVOfdoWhtHQolOv8vzyDzjfXs0AH1tNanQhqdExkwyZ6ZA0cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHz53zgr5PjjTSp1M3j1MdrdZ8m2K22yapgh/2qUT6+rg++08o
	+BygvvghH3lLKCYA+6KF13pTi+m4Y1UnAQMQ602ymn2o4AH/KA+wYUO0GhRBGfs+Mact3WoCLUd
	EGrJdge0FYXA60mkUCiURyLNjYDmRGkqHLbDvYAzB
X-Gm-Gg: AZuq6aJJnj50NR4+GAlwjXjIL6l/QygrtrocXzo3NQna0OZ2hjVuafwh7e5WXT65FLc
	wWj+2xrI5VuFKPNbrRgcMWktimcUip4juMq5IiRJzm+Voe1LRS8dg3JODiP8zk1TaS9iCYxxmE6
	sJ6fHvqg4R44W+Qa3bQiUsY6oXMCvCUY9Uck0QyTiMJd2A/Oczkjpa29fLrGMyxzk0n2I9DXwNJ
	5dMOBnYJxzEJhA0++XaC3o8kwn4DJBJ0dzmdHkAjTKbtDVJCUnWMCdCtrIKxX9/f+sUGOVKv7Bv
	zv8eLsY0K6PbrTlN+brdKX/R
X-Received: by 2002:ac8:5f4c:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-502f8dd1f29mr828171cf.7.1769118111204; Thu, 22 Jan 2026
 13:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 13:41:39 -0800
X-Gm-Features: AZwV_QiUCaGM32Wq1UYdnioBziJ8H0aqaz5os6V0HI-LhNnVIc8UrlMk0F6amZ4
Message-ID: <CAJuCfpEULwMTxAzxUdzfpHe2=+umXL6HFMvydkqW=tP8mB2ewg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
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

On Thu, Jan 22, 2026 at 5:03=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> It is confusing to have __vma_enter_exclusive_locked() return 0, 1 or an
> error (but only when waiting for readers in TASK_KILLABLE state), and
> having the return value be stored in a stack variable called 'locked' is
> further confusion.
>
> More generally, we are doing a lock of rather finnicky things during the
> acquisition of a state in which readers are excluded and moving out of th=
is
> state, including tracking whether we are detached or not or whether an
> error occurred.
>
> We are implementing logic in __vma_enter_exclusive_locked() that
> effectively acts as if 'if one caller calls us do X, if another then do Y=
',
> which is very confusing from a control flow perspective.
>
> Introducing the shared helper object state helps us avoid this, as we can
> now handle the 'an error arose but we're detached' condition correctly in
> both callers - a warning if not detaching, and treating the situation as =
if
> no error arose in the case of a VMA detaching.
>
> This also acts to help document what's going on and allows us to add some
> more logical debug asserts.
>
> Also update vma_mark_detached() to add a guard clause for the likely
> 'already detached' state (given we hold the mmap write lock), and add a
> comment about ephemeral VMA read lock reference count increments to clari=
fy
> why we are entering/exiting an exclusive locked state here.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap_lock.c | 144 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 91 insertions(+), 53 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index f73221174a8b..75166a43ffa4 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -46,20 +46,40 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_PER_VMA_LOCK
>
> +/* State shared across __vma_[enter, exit]_exclusive_locked(). */
> +struct vma_exclude_readers_state {
> +       /* Input parameters. */
> +       struct vm_area_struct *vma;
> +       int state; /* TASK_KILLABLE or TASK_UNINTERRUPTIBLE. */
> +       bool detaching;
> +
Are these:
            /* Output parameters. */
?
> +       bool detached;
> +       bool exclusive; /* Are we exclusively locked? */
> +};
> +
>  /*
>   * Now that all readers have been evicted, mark the VMA as being out of =
the
>   * 'exclude readers' state.
>   *
>   * Returns true if the VMA is now detached, otherwise false.
>   */
> -static bool __must_check __vma_exit_exclusive_locked(struct vm_area_stru=
ct *vma)
> +static void __vma_exit_exclusive_locked(struct vma_exclude_readers_state=
 *ves)
>  {
> -       bool detached;
> +       struct vm_area_struct *vma =3D ves->vma;
> +
> +       VM_WARN_ON_ONCE(ves->detached);
> +       VM_WARN_ON_ONCE(!ves->exclusive);
>
> -       detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG=
,
> -                                        &vma->vm_refcnt);
> +       ves->detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS=
_FLAG,
> +                                             &vma->vm_refcnt);
>         __vma_lockdep_release_exclusive(vma);
> -       return detached;
> +}
> +
> +static unsigned int get_target_refcnt(struct vma_exclude_readers_state *=
ves)
> +{
> +       const unsigned int tgt =3D ves->detaching ? 0 : 1;
> +
> +       return tgt | VM_REFCNT_EXCLUDE_READERS_FLAG;
>  }
>
>  /*
> @@ -69,30 +89,31 @@ static bool __must_check __vma_exit_exclusive_locked(=
struct vm_area_struct *vma)
>   * Note that this function pairs with vma_refcount_put() which will wake=
 up this
>   * thread when it detects that the last reader has released its lock.
>   *
> - * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in cases =
where we
> - * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fatal =
signal
> - * is permitted to kill it.
> + * The ves->state parameter ought to be set to TASK_UNINTERRUPTIBLE in c=
ases
> + * where we wish the thread to sleep uninterruptibly or TASK_KILLABLE if=
 a fatal
> + * signal is permitted to kill it.
>   *
> - * The function will return 0 immediately if the VMA is detached, and 1 =
once the
> - * VMA has evicted all readers, leaving the VMA exclusively locked.
> + * The function sets the ves->locked parameter to true if an exclusive l=
ock was

s/ves->locked/ves->exclusive

> + * acquired, or false if the VMA was detached or an error arose on wait.
>   *
> - * If the function returns 1, the caller is required to invoke
> - * __vma_exit_exclusive_locked() once the exclusive state is no longer r=
equired.
> + * If the function indicates an exclusive lock was acquired via ves->exc=
lusive
> + * (or equivalently, returning 0 with !ves->detached),

I would remove the mention of that equivalence because with this
change, return 0 simply indicates that the operation was successful
and should not be used to infer any additional states. To get specific
state the caller should use proper individual ves fields. Using return
value for anything else defeats the whole purpose of this cleanup.

> the caller is required to
> + * invoke __vma_exit_exclusive_locked() once the exclusive state is no l=
onger
> + * required.
>   *
> - * If state is set to something other than TASK_UNINTERRUPTIBLE, the fun=
ction
> - * may also return -EINTR to indicate a fatal signal was received while =
waiting.
> + * If ves->state is set to something other than TASK_UNINTERRUPTIBLE, th=
e
> + * function may also return -EINTR to indicate a fatal signal was receiv=
ed while
> + * waiting.
>   */
> -static int __vma_enter_exclusive_locked(struct vm_area_struct *vma,
> -               bool detaching, int state)
> +static int __vma_enter_exclusive_locked(struct vma_exclude_readers_state=
 *ves)
>  {
> -       int err;
> -       unsigned int tgt_refcnt =3D VM_REFCNT_EXCLUDE_READERS_FLAG;
> +       struct vm_area_struct *vma =3D ves->vma;
> +       unsigned int tgt_refcnt =3D get_target_refcnt(ves);
> +       int err =3D 0;
>
>         mmap_assert_write_locked(vma->vm_mm);
> -
> -       /* Additional refcnt if the vma is attached. */
> -       if (!detaching)
> -               tgt_refcnt++;
> +       VM_WARN_ON_ONCE(ves->detached);
> +       VM_WARN_ON_ONCE(ves->exclusive);

Aren't these output parameters? If so, why do we stipulate their
initial values instead of setting them appropriately?

>
>         /*
>          * If vma is detached then only vma_mark_attached() can raise the
> @@ -101,37 +122,39 @@ static int __vma_enter_exclusive_locked(struct vm_a=
rea_struct *vma,
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> -       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt))
> +       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt)) {
> +               ves->detached =3D true;
>                 return 0;
> +       }
>
>         __vma_lockdep_acquire_exclusive(vma);
>         err =3D rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
> -                  state);
> +                  ves->state);
>         if (err) {
> -               if (__vma_exit_exclusive_locked(vma)) {
> -                       /*
> -                        * The wait failed, but the last reader went away
> -                        * as well. Tell the caller the VMA is detached.
> -                        */
> -                       WARN_ON_ONCE(!detaching);
> -                       err =3D 0;
> -               }
> +               __vma_exit_exclusive_locked(ves);
>                 return err;

Nice! We preserve both error and detached state information.

>         }
> -       __vma_lockdep_stat_mark_acquired(vma);
>
> -       return 1;
> +       __vma_lockdep_stat_mark_acquired(vma);
> +       ves->exclusive =3D true;
> +       return 0;
>  }
>
>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_s=
eq,
>                 int state)
>  {
> -       int locked;
> +       int err;
> +       struct vma_exclude_readers_state ves =3D {
> +               .vma =3D vma,
> +               .state =3D state,
> +       };
>
> -       locked =3D __vma_enter_exclusive_locked(vma, false, state);
> -       if (locked < 0)
> -               return locked;
> +       err =3D __vma_enter_exclusive_locked(&ves);
> +       if (err) {
> +               WARN_ON_ONCE(ves.detached);

I believe the above WARN_ON_ONCE() should stay inside of
__vma_enter_exclusive_locked(). Its correctness depends on the
implementation details of __vma_enter_exclusive_locked(). More
specifically, it is only correct because
__vma_enter_exclusive_locked() returns 0 if the VMA is detached, even
if there was a pending SIGKILL.

> +               return err;
> +       }
>
>         /*
>          * We should use WRITE_ONCE() here because we can have concurrent=
 reads
> @@ -141,9 +164,11 @@ int __vma_start_write(struct vm_area_struct *vma, un=
signed int mm_lock_seq,
>          */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>
> -       /* vma should remain attached. */
> -       if (locked)
> -               WARN_ON_ONCE(__vma_exit_exclusive_locked(vma));
> +       if (!ves.detached) {

Strictly speaking the above check should be checking ves->exclusive
instead of !ves.detached. What you have is technically correct but
it's again related to that comment:

"If the function indicates an exclusive lock was acquired via
ves->exclusive (or equivalently, returning 0 with !ves->detached), the
caller is required to invoke __vma_exit_exclusive_locked() once the
exclusive state is no longer required."

So, here you are using returning 0 with !ves->detached as an
indication that the VMA was successfully locked. I think it's less
confusing if we use the field dedicated for that purpose.

> +               __vma_exit_exclusive_locked(&ves);
> +               /* VMA should remain attached. */
> +               WARN_ON_ONCE(ves.detached);
> +       }
>
>         return 0;
>  }
> @@ -151,7 +176,12 @@ EXPORT_SYMBOL_GPL(__vma_start_write);
>
>  void vma_mark_detached(struct vm_area_struct *vma)
>  {
> -       bool detached;
> +       struct vma_exclude_readers_state ves =3D {
> +               .vma =3D vma,
> +               .state =3D TASK_UNINTERRUPTIBLE,
> +               .detaching =3D true,
> +       };
> +       int err;
>
>         vma_assert_write_locked(vma);
>         vma_assert_attached(vma);
> @@ -160,18 +190,26 @@ void vma_mark_detached(struct vm_area_struct *vma)
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> -       detached =3D __vma_refcount_put(vma, NULL);
> -       if (unlikely(!detached)) {
> -               /* Wait until vma is detached with no readers. */
> -               if (__vma_enter_exclusive_locked(vma, true, TASK_UNINTERR=
UPTIBLE)) {
> -                       /*
> -                        * Once this is complete, no readers can incremen=
t the
> -                        * reference count, and the VMA is marked detache=
d.
> -                        */
> -                       detached =3D __vma_exit_exclusive_locked(vma);
> -                       WARN_ON_ONCE(!detached);
> -               }
> +       if (likely(__vma_refcount_put(vma, NULL)))
> +               return;
> +
> +       /*
> +        * Wait until the VMA is detached with no readers. Since we hold =
the VMA
> +        * write lock, the only read locks that might be present are thos=
e from
> +        * threads trying to acquire the read lock and incrementing the
> +        * reference count before realising the write lock is held and
> +        * decrementing it.
> +        */
> +       err =3D __vma_enter_exclusive_locked(&ves);
> +       if (!err && !ves.detached) {

Same here, we should be checking ves->exclusive to decide if
__vma_exit_exclusive_locked() should be called or not.

> +               /*
> +                * Once this is complete, no readers can increment the
> +                * reference count, and the VMA is marked detached.
> +                */
> +               __vma_exit_exclusive_locked(&ves);
>         }
> +       /* If an error arose but we were detached anyway, we don't care. =
*/
> +       WARN_ON_ONCE(!ves.detached);
>  }
>
>  /*
> --
> 2.52.0
