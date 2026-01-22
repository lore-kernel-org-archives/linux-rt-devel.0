Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D93563E3
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105288; cv=pass; b=eBq1bCbFSb2bROHs23knbQCbowrbHWFKV2XpRMnIQdfdjg4Uey5GvzZaQU3KgA25rkDhh379VfJy1Jr5AcKVBarrJSZjxm6mEvSW+aCAaO3hfK1iZ/KZtK4zAwl1Aew07DR+VPVARSHO4N2R2yNVhVbWo/JpnAgMl+Qw1HUOe0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105288; c=relaxed/simple;
	bh=zdLkiSlU9Fd9LEr704oOQxFl5PdDq+moOPjzjLViXzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSGpgGOoPdKxFnMjRat3tYPqhvDgmWJF8Hd1BZXr/d78Ufy9pB/cgDhquJogk8fA74p1BcuoxttEsYMJ0UMbGgUdMFC5ioakDKL9xAlHmgPoUPGerQirZnp9INcHqNRBYWLX/FQbcGmDH8Fcmm4MS5a019HyqB7qcdWVJmjVFpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jO8sDxV; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jO8sDxV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014b5d8551so24121cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 10:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105279; cv=none;
        d=google.com; s=arc-20240605;
        b=VhgOpl8LOSg7J0BkcOW6wGlj10n7LVZzuD1iK4wNaOvpJfJw/FGVZZv2gpVOg10ZpW
         o/Vhjf45+0ZOw1TWquh4ZXUyqskQp3CpyaKHZ3M7ILUjw3wzHb5vHi3wzUgccveh7P/A
         zyu8r5j8CsYBh5obVr9HLfnBuGW/fnWw4yTRRYK7TeFr+FCJ89d95iU+pjA4l0YGpMGf
         Y+lgZwY+NzGRoPIF5c4yRE0OMvlDdL6ATdxKXbkKKz9i4guxnLacMVVphbCwmESa6ibQ
         EGSImsMtcbcPherTyIWf+PynTVaz5n1BgOC2vE7Basa9fcD+A7R0aeHygXYQZ/uZ1lfm
         tgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjdUwnpsHtoIlxN53mjKwTtHv8VX23Qu//ARq0k4aO4=;
        fh=UJyfbh3DxrxdNMDkfPTOKO1oWEYw95mnRELKg6SwSTw=;
        b=Ok2RvuQPpaA5O2Z07aNyr+m+asl3OibpN7WS4hz66yKWC94pfHZ7s5gVIGzbLHOA3k
         5uG/t5i+HGPQl1nd2Y7Wn7rx1cD/LCk+uBWaS5JQFXvVVfpJ+Dkb5w3ELGbQzUfDOC+w
         DcM3+AZXQVg9R/rUaZfqH1e/vRxgZDYCZFGDNXDKG8ZXG2FJ5AEz4VCUR24E5tR2SfWn
         IoFZhIJThWN58gkiVM28GPU1jUUd/03s46PNzq3zBIJk/xixQdv7R82XO7SFsAfdvqYS
         mhNf+FfB7s/5akuHbkmIQZCu9ip/0/a1GK9RwxA/O0T546y8ZvkICbBELIJSFCzmxbOE
         HDEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769105279; x=1769710079; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjdUwnpsHtoIlxN53mjKwTtHv8VX23Qu//ARq0k4aO4=;
        b=1jO8sDxVb7fnaCDzlgbprPWdL0o5TNMqLop/NrMI/NdF3zT+G637CTGcOy63T+hIi6
         K56ksLULuvExOGfBoyiGwKf1Af73N/ODHh3OxWYnPO37iDltXrvo8Qf/X04jr4oind7j
         hOVwLF1idTMZzwGhF9xmh1SYt+nKeQkyJuP3G6bfoNNgfzgTkl+XAlQQFJ+y7+djiYUo
         qh4Q1IVV3trlq02vl5o4jXqDkc6gkehHrBsORuyD3oieh+xa4kje4n8AnCvf3wIPR/gu
         sJcN2nzkZ7Ku3DHD3eJ97kiVsCgHwG3gpL4P/0Kbl3IgZCgUxr9/8qcdZveCpfWzAMST
         OuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105279; x=1769710079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjdUwnpsHtoIlxN53mjKwTtHv8VX23Qu//ARq0k4aO4=;
        b=s28K7/ETYVKZzhLcr2pA0tYV1nAOzIQvTMpnQ8mOwXh/QTxxgEaTfh5adB7SKn603M
         h67kqzSkEpzOHwadR4QMzCRiL4o5l8aLAs0+uwdcqRYLIiT7kF/PSJrGe867b3gfJaBb
         tiA85Tau/9yaQc0nlK7LT9ab+o1Pmpx53kAvyenT3z5u0qB2jCJx0V+WIy0FrOGbBEUY
         U/S8tDvhD4dluLXRvaHe0fArb4Y2nhxuzx1PmI3d2GtWyW7iqXTYw+7Mir9NGJK4zOFD
         sdzVBVZHrla58u8S3J9n0DM7EoOTqV2+/nNA2wROiraVjmQzyCg6XRxTlPO8g3GIytcc
         s3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOnlFt+Ss263nGI+TMfB3ykjzmvby8oaeD9NI8hkjSB0qvlLCEtg8p0QQS2z0Bt+GCOljqmcSi6VTosnLdtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyIYJG/1eaNQbkyFtqzw7VDE6lO4EczVyaAqwGjlHTzHKffGX5
	83yuF9kOwU8vAywML6Gj3mcOPA1iL99KNwZYV5C1JM2BHTnxrL1LuN96YODuxq5pORVjmyFcs/o
	NYnTue9YYqY3SjK9LGkSOJH6C9mp3t7sFbzg7RyqN
X-Gm-Gg: AZuq6aJl5nPMEgpcKAqH5NZmYP+Ihvpdg1rcphbgUZlAbCHBc0l42lBOAocWdUSVrd3
	+DHtUe1r8i890A3He9xcCTTtW+ceaFURi/thobQt4eHECy35mWtKDgK8YPR5maPxPN/QEXdMa1w
	PYc2wNr8fBgtsh61gYbZmVvPrfjjacm0f+WYELJZaX5hOlJfAjFoCVqh8kHGT8jsV3AulqsBZlc
	GKmjo49VU8horwqqjY2CElOOQ7wL5Cwj/Kam73i/hfmNYf8+trGrn6V1PyjxltmOHB1ip+GuWMH
	8tlo6LwPi30vt55/dICbRenl
X-Received: by 2002:ac8:7f11:0:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-502f808dfb6mr111741cf.12.1769105278126; Thu, 22 Jan 2026
 10:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769085814.git.lorenzo.stoakes@oracle.com> <c51d6396d78532d85a542da07ba783bc838b852f.1769085814.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <c51d6396d78532d85a542da07ba783bc838b852f.1769085814.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 10:07:47 -0800
X-Gm-Features: AZwV_QjulxiVd5nvn-p3ujVEBBr76cKQScvmhG9dtzEX3D3VZga5MHrIgn1oKxk
Message-ID: <CAJuCfpF-tVr==bCf-PXJFKPn99yRjfONeDnDtPvTkGUfyuvtcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm/vma: rename is_vma_write_only(), separate out
 shared refcount put
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

On Thu, Jan 22, 2026 at 4:50=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The is_vma_writer_only() function is misnamed - this isn't determining if
> there is only a write lock, as it checks for the presence of the
> VM_REFCNT_EXCLUDE_READERS_FLAG.
>
> Really, it is checking to see whether readers are excluded, with a
> possibility of a false positive in the case of a detachment (there we
> expect the vma->vm_refcnt to eventually be set to
> VM_REFCNT_EXCLUDE_READERS_FLAG, whereas for an attached VMA we expect it =
to
> eventually be set to VM_REFCNT_EXCLUDE_READERS_FLAG + 1).
>
> Rename the function accordingly.
>
> Relatedly, we use a finnicky __refcount_dec_and_test() primitive directly
> in vma_refcount_put(), using the old value to determine what the referenc=
e
> count ought to be after the operation is complete (ignoring racing
> reference count adjustments).

IIUC, __refcount_dec_and_test() can decrement the refcount by only 1
and the old value returned (oldcnt) will be the exact value that it
was before this decrement. Therefore oldcnt - 1 must reflect the
refcount value after the decrement. It's possible the refcount gets
manipulated after this operation but that does not make this operation
wrong. I don't quite understand why you think that's racy or finnicky.

>
> Wrap this into a __vma_refcount_put() function, which we can then utilise
> in vma_mark_detached() and thus keep the refcount primitive usage
> abstracted.
>
> Also adjust comments, removing duplicative comments covered elsewhere and
> adding more to aid understanding.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mmap_lock.h | 62 +++++++++++++++++++++++++++++++--------
>  mm/mmap_lock.c            | 18 +++++-------
>  2 files changed, 57 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index a764439d0276..0b3614aadbb4 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -122,15 +122,27 @@ static inline void vma_lock_init(struct vm_area_str=
uct *vma, bool reset_refcnt)
>         vma->vm_lock_seq =3D UINT_MAX;
>  }
>
> -static inline bool is_vma_writer_only(int refcnt)
> +/**
> + * are_readers_excluded() - Determine whether @refcnt describes a VMA wh=
ich has
> + * excluded all VMA read locks.
> + * @refcnt: The VMA reference count obtained from vm_area_struct->vm_ref=
cnt.
> + *
> + * We may be raced by other readers temporarily incrementing the referen=
ce
> + * count, though the race window is very small, this might cause spuriou=
s
> + * wakeups.
> + *
> + * In the case of a detached VMA, we may incorrectly indicate that reade=
rs are
> + * excluded when one remains, because in that scenario we target a refco=
unt of
> + * VM_REFCNT_EXCLUDE_READERS_FLAG, rather than the attached target of
> + * VM_REFCNT_EXCLUDE_READERS_FLAG + 1.
> + *
> + * However, the race window for that is very small so it is unlikely.
> + *
> + * Returns: true if readers are excluded, false otherwise.
> + */
> +static inline bool are_readers_excluded(int refcnt)
>  {
>         /*
> -        * With a writer and no readers, refcnt is VM_REFCNT_EXCLUDE_READ=
ERS_FLAG
> -        * if the vma is detached and (VM_REFCNT_EXCLUDE_READERS_FLAG + 1=
) if it is
> -        * attached. Waiting on a detached vma happens only in
> -        * vma_mark_detached() and is a rare case, therefore most of the =
time
> -        * there will be no unnecessary wakeup.
> -        *
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> @@ -138,18 +150,42 @@ static inline bool is_vma_writer_only(int refcnt)
>                 refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
>  }
>
> +static inline bool __vma_refcount_put(struct vm_area_struct *vma, int *r=
efcnt)
> +{
> +       int oldcnt;
> +       bool detached;
> +
> +       detached =3D __refcount_dec_and_test(&vma->vm_refcnt, &oldcnt);
> +       if (refcnt)
> +               *refcnt =3D oldcnt - 1;
> +       return detached;

IIUC there is always a connection between detached and *refcnt
resulting value. If detached=3D=3Dtrue then the resulting *refcnt has to
be 0. If so, __vma_refcount_put() can simply return (oldcnt - 1) as
new count:

static inline int __vma_refcount_put(struct vm_area_struct *vma)
{
       int oldcnt;

       __refcount_dec_and_test(&vma->vm_refcnt, &oldcnt);
       return oldcnt - 1;
}

And later:

newcnt =3D __vma_refcount_put(&vma->vm_refcnt);
detached =3D newcnt =3D=3D 0;

> +}
> +
> +/**
> + * vma_refcount_put() - Drop reference count in VMA vm_refcnt field due =
to a
> + * read-lock being dropped.
> + * @vma: The VMA whose reference count we wish to decrement.
> + *
> + * If we were the last reader, wake up threads waiting to obtain an excl=
usive
> + * lock.
> + */
>  static inline void vma_refcount_put(struct vm_area_struct *vma)
>  {
> -       /* Use a copy of vm_mm in case vma is freed after we drop vm_refc=
nt */
> +       /* Use a copy of vm_mm in case vma is freed after we drop vm_refc=
nt. */
>         struct mm_struct *mm =3D vma->vm_mm;
> -       int oldcnt;
> +       int refcnt;
> +       bool detached;
>
>         rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> -       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
>
> -               if (is_vma_writer_only(oldcnt - 1))
> -                       rcuwait_wake_up(&mm->vma_writer_wait);
> -       }
> +       detached =3D __vma_refcount_put(vma, &refcnt);
> +       /*
> +        * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> +        * their reference count, so wake it up if we were the last reade=
r
> +        * blocking it from being acquired.
> +        */
> +       if (!detached && are_readers_excluded(refcnt))
> +               rcuwait_wake_up(&mm->vma_writer_wait);
>  }
>
>  /*
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 75dc098aea14..ebacb57e5f16 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -130,25 +130,23 @@ EXPORT_SYMBOL_GPL(__vma_start_write);
>
>  void vma_mark_detached(struct vm_area_struct *vma)
>  {
> +       bool detached;
> +
>         vma_assert_write_locked(vma);
>         vma_assert_attached(vma);
>
>         /*
> -        * We are the only writer, so no need to use vma_refcount_put().
> -        * The condition below is unlikely because the vma has been alrea=
dy
> -        * write-locked and readers can increment vm_refcnt only temporar=
ily

I think the above part of the comment is still important and should be
kept intact.

> -        * before they check vm_lock_seq, realize the vma is locked and d=
rop
> -        * back the vm_refcnt. That is a narrow window for observing a ra=
ised
> -        * vm_refcnt.
> -        *
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> -       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> +       detached =3D __vma_refcount_put(vma, NULL);
> +       if (unlikely(!detached)) {
>                 /* Wait until vma is detached with no readers. */
>                 if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) =
{
> -                       bool detached;
> -
> +                       /*
> +                        * Once this is complete, no readers can incremen=
t the
> +                        * reference count, and the VMA is marked detache=
d.
> +                        */
>                         __vma_exit_locked(vma, &detached);
>                         WARN_ON_ONCE(!detached);
>                 }
> --
> 2.52.0
>
