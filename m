Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC377237713
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769405795; cv=pass; b=DlLFRXFbp3S3v5V3xhQp6LIvons1ne3sLdh7RfHTXTbRPc3NvrwaNtYsTy53XOa1I5uclBSw+jm8olKfuc2Me5n5oYM6kSmbHVj7ubz9XnobC8jPxPRVr0WDlCfxHCjaBTVh/29jAUZ/PP+kwNI0CRqYqQvkV1bIU4oRWi0/3/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769405795; c=relaxed/simple;
	bh=atmgn5WeGIstfYtfIxu89gacAJZAeZCOoUQfXtXjrbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+jmvFGnLSlni9OcDyhKWvJZ56clBKufcps5t7iTX2YPeNTZ+nvYOvTypgw+arVv7WPHgea6a4rrl5J6nOJPZdQ4t1nijZzisavvs1WDcLg8hHNeVilBMXZ644jdVdwJ3hsJUO2TP8MfTR3Yt78xPbY0cYNXnmMN+ct+2OuhdqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tNezZho; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tNezZho"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b5d8551so791731cf.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 25 Jan 2026 21:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769405790; cv=none;
        d=google.com; s=arc-20240605;
        b=hewy5iy8jKRd4FvzvvbHrohHW47GzAMRKnRoyOUwzunGg+st2vbpnPpJ/5M9DhBd/S
         5dZv8kls1g+GIFO67Ops7v2TxvHdNMXbM8LtZFaybSjXUEjAs1OCmx0UsrXCVulS9VeO
         lb5pYqN+Up4Nq923djplRYiuaWyHx3RXIztppsuKedLz5PsAsRgpdnI60XFa9l0EUxd3
         ROtVmzR2ugP9XQEu81E7E5PTt2urL6VNiCGVJ+nByZxHibjVGJkryk8U2hFKiUcRLaLI
         Z0xqpISp1CnCf3nuGSwDbvNKFxzb88sl2N3uyTznVZSH9WX1z6skPb9eE4vJsnuxKFap
         aILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I6xZq7LrfvfhhMsxNvjZUWzjYExAB/8BW1cOYBT9G50=;
        fh=RQ2eA6uRO5qqpWsgPZAudRdTGhWEA+0yRtN9JYA1ayo=;
        b=D+L+XvJnDCFXp+zxtbwGq7wjtdON9F9J/sSCgCHTnDJjPewSKMdVVKPoVgimGDfIQB
         DmFFRA85L5KnLXInpzTVG+sa9/4I7ZezYtMaet7a31R2B/2d3M7Y/vVMGfkbF+APs4za
         elRkMA0o8RjcdV9PoJJ/CsbJhc7mSQzItpjdyplnRaFq9h/XfUFiHAF/E5JX24bNHlpQ
         eAmpXLg7UrLASXMXGZUDgA2+V0xOnHI1ceUpGVP5NyKCCibMxSknxObYv0DWM1SkJQR0
         vt7kij5DFWRZGWhpshlDuoD9UGXb6wGt89ClKxyRAsSr4f4nbuL38avM1Rt5Yjen8aFM
         O8Ow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769405790; x=1770010590; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6xZq7LrfvfhhMsxNvjZUWzjYExAB/8BW1cOYBT9G50=;
        b=4tNezZhoWjyUf3wkAQUaPT9y7mAz+/Q5MNptoMJaUgyn48DG2JQGBT8fXQKGS09gRC
         aWecdjA5q6iFvw7VUjAugLGHZ8lmA/03UlXfWYK268RyZcPu/ZTisikcF3/KvVCfon+i
         IOzDCfIP8DXDnuOb0Wx4kaZw+y93X2XSqlIWe0uUV6oovJT615HdNjegY03yIFKWmE1e
         Y2U2uKFSUmQyeFDig8Qc7VBjOWjx77VyGuRk7DUTGYJs5UXdQhtC2Hay5XrA4YAxyuEu
         yUnBMgE6Yme4Zz2lizSZi/tOjAwDGOuAjfMiyjcbsyTmdVJyQLPYtpJQ+q5y/OIKrLuK
         qrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769405790; x=1770010590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6xZq7LrfvfhhMsxNvjZUWzjYExAB/8BW1cOYBT9G50=;
        b=iA/XwFDU9HAcFc0mGQhtjJawTqzjqbiKJPS5NUzKO5jgWQqVeE8nX1+1rqGF2aTU8M
         nge/p/kQhG4T21ddKZ5L8HEGmX6Vq1gk2evkgBVxFsTUxwz3E4rEG6uz9iK79BecwIEF
         PRZpahUs2tDNsBKWo7mQ2DgDgjEs0qU7qONtUa70usphrMuHXmBqNZ3vWGAnX9BGypor
         llgo8KXZuoMEJ0GJ8CAxjGPvFnfyIuAuddeMc7RkuECowjRyhcr/MaHMw5VW+icEj9u6
         zf6stB+k/8jqqER+PcVFHw/xSgqLAojy7rUARAgk7aQ73/1xyjYNDmmGeS1rwfumQq6J
         InmA==
X-Forwarded-Encrypted: i=1; AJvYcCVt+rremNFltfdv05K1h9AvcamU0GTnvxsrb6e3b5G0Xp8GdvKwrRfY4j2cSWxxEwE0o9oHd8tbF0qkQhPapg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN8ILBeuvSGD1lasr8/h4EXxghYTGDZCuXl9fGC4I0O+5ffL3W
	OCg6JitJAHF7M7grVYSuhNMDU0y5tgdq/ZGqgy49KEiuU4ZPaGKZP6+L9cQCca6Q/VVTkLis81M
	MEDl2bAHUxnzfR4QwdejD6OnNGOD+0d5e732JjmCZ
X-Gm-Gg: AZuq6aKI5sncDvOHcBuwYDcCSSvsQGrXJ/KecYR0uiuZHA0OHKdUmptj4u15j7tGJP6
	qLBhSXqXg1PFC53Bp8wKaSKQ1xH0Wgw8wkPZZ9N9rDXtW8aGseHUC4rv2jwjMtduXpGmrwfR8pJ
	a3nI/milKfgOKLNhill6y6LwLvejIOZxXyQK+3YaTpAzIq57It7I49FZ9M4KWYIPppXWV9SscVj
	C7oQBCMf8lgjOTfgzbAswhXnCTTKhMKEBEnpohlHiIF5IhHl2tMKn+XDZL2l9To6j4X7ReXAdBi
	pVW0
X-Received: by 2002:ac8:5f93:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-5031428fc37mr7858901cf.7.1769405790260; Sun, 25 Jan 2026
 21:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com> <32053580bff460eb1092ef780b526cefeb748bad.1769198904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <32053580bff460eb1092ef780b526cefeb748bad.1769198904.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Jan 2026 21:36:19 -0800
X-Gm-Features: AZwV_QiN0QWWeFWiJptYH_T4KdRYx16ZLo4mjaKA-kzllU5XbwC19rarlh3QeBo
Message-ID: <CAJuCfpH1u6N7FXi=2Gn+WWDW5M5reupQVkKebGqRcbr84oj3HA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] mm/vma: rename is_vma_write_only(), separate out
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

On Fri, Jan 23, 2026 at 12:12=E2=80=AFPM Lorenzo Stoakes
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
> Relatedly, we use a __refcount_dec_and_test() primitive directly in
> vma_refcount_put(), using the old value to determine what the reference
> count ought to be after the operation is complete (ignoring racing
> reference count adjustments).
>
> Wrap this into a __vma_refcount_put_return() function, which we can then
> utilise in vma_mark_detached() and thus keep the refcount primitive usage
> abstracted.
>
> This function, as the name implies, returns the value after the reference
> count has been updated.
>
> This reduces duplication in the two invocations of this function.
>
> Also adjust comments, removing duplicative comments covered elsewhere and
> adding more to aid understanding.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mmap_lock.h | 66 +++++++++++++++++++++++++++++++--------
>  mm/mmap_lock.c            | 17 +++++-----
>  2 files changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index a764439d0276..294fb282052d 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -122,15 +122,22 @@ static inline void vma_lock_init(struct vm_area_str=
uct *vma, bool reset_refcnt)
>         vma->vm_lock_seq =3D UINT_MAX;
>  }
>
> -static inline bool is_vma_writer_only(int refcnt)
> +/*
> + * This function determines whether the input VMA reference count descri=
bes a
> + * VMA which has excluded all VMA read locks.
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
> +static inline bool __vma_are_readers_excluded(int refcnt)
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
> @@ -138,18 +145,51 @@ static inline bool is_vma_writer_only(int refcnt)
>                 refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
>  }
>
> +/*
> + * Actually decrement the VMA reference count.
> + *
> + * The function returns the reference count as it was immediately after =
the
> + * decrement took place. If it returns zero, the VMA is now detached.
> + */
> +static inline __must_check unsigned int
> +__vma_refcount_put_return(struct vm_area_struct *vma)
> +{
> +       int oldcnt;
> +
> +       if (__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt))
> +               return 0;
> +
> +       return oldcnt - 1;
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
> +       int newcnt;
>
>         rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> -       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
>
> -               if (is_vma_writer_only(oldcnt - 1))
> -                       rcuwait_wake_up(&mm->vma_writer_wait);
> -       }
> +       newcnt =3D __vma_refcount_put_return(vma);
> +       /*
> +        * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> +        * their reference count, so wake it up if we were the last reade=
r
> +        * blocking it from being acquired.
> +        *
> +        * We may be raced by other readers temporarily incrementing the
> +        * reference count, though the race window is very small, this mi=
ght
> +        * cause spurious wakeups.
> +        */
> +       if (newcnt && __vma_are_readers_excluded(newcnt))
> +               rcuwait_wake_up(&mm->vma_writer_wait);
>  }
>
>  /*
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 75dc098aea14..6be1bbcde09e 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -134,21 +134,24 @@ void vma_mark_detached(struct vm_area_struct *vma)
>         vma_assert_attached(vma);
>
>         /*
> -        * We are the only writer, so no need to use vma_refcount_put().
> -        * The condition below is unlikely because the vma has been alrea=
dy
> -        * write-locked and readers can increment vm_refcnt only temporar=
ily
> -        * before they check vm_lock_seq, realize the vma is locked and d=
rop
> -        * back the vm_refcnt. That is a narrow window for observing a ra=
ised
> -        * vm_refcnt.
> +        * This condition - that the VMA is still attached (refcnt > 0) -=
 is
> +        * unlikely, because the vma has been already write-locked and re=
aders
> +        * can increment vm_refcnt only temporarily before they check
> +        * vm_lock_seq, realize the vma is locked and drop back the
> +        * vm_refcnt. That is a narrow window for observing a raised vm_r=
efcnt.
>          *
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> -       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> +       if (unlikely(__vma_refcount_put_return(vma))) {
>                 /* Wait until vma is detached with no readers. */
>                 if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) =
{
>                         bool detached;
>
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
