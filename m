Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D03BFE4D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119966; cv=pass; b=gpLatWciBjxy7/O9VsnGIFXpMx9c5xoNC1A2UzqTiZQ8pbtFNwH8XJe2Idij/czfeWSjBvz+KwPyn4PNum3YQPOVVofsmL9kSe3OWfl0CtBIUBtwQ0+BCsymRyjnLkkNhHSnBnDI+lO0QNByn369orDkT8G9CbZIRPiZdiuyCrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119966; c=relaxed/simple;
	bh=R5s+nMSDXxBelfMom2Ansta3bLeMKfxUh8lXMvRRj6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVCZ+3u5JegjlUfwVyJk/K2YMUU5aoqtePT8j6yrkIOymmmllbgiy7Os+Y9R5EkLO/iGHxl050ZmKTU3Ok1qJbbmAmdQV9D7P7HPV4YHkV8tk8DyUE7V0NmCgQZQE8q2PB1U1fU7ijJa2OUu5ff4WHloogxnBLldKhT9b18HuEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIZRSg2A; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIZRSg2A"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014acad6f2so72701cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 14:12:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769119958; cv=none;
        d=google.com; s=arc-20240605;
        b=RfZR6mPXPvsN5TIivOtuE85FAIgJlbBS/F1jf/mZhaoDxtfZf5y4KGqhh/5jwPTF/1
         TfSVMlL8ATq2FZJNo9iBjvj8Rc3PKBIG4r7vv1bvMAqVhyFaxyphOtIEb+MiGsnnCs5v
         ZGPgTeNlnonxxQ3+4XMq8igsAhgz1vVA/qjV0ocil6P+pau0zrf4fk49wX6aQvRtDig2
         hQoj9TvbdiiXwRCaR9uDcISEFQikTgoEHdlmXiAffk72wXnlF7e3mFSj5RsunyDt6IfB
         8Xy8IpeZQUG4FAW5hKHYHHRyrKHAs9ErX0+LjajyOgBctxbuvJMd12CbW9BlkfqqVv4j
         u/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0Z4UtmHMtrm22Dzvewt+n+aqxxbFiEfZAYYSqL4AsM=;
        fh=DXJOBX9AFcUZvEQMSvdFWc7YVHQQM7Death2fOw4NHI=;
        b=KidPzpLRI+4Yco9jjqEyHddaY+L+BtOc70Miln9NvW6qzVrXmqsXJJ1KPjn+lAI8/V
         ebs5+th5A6VQPqxovqGqXnmHikvKNpteN6MWvEYp+p+vthQ2EoTn1Utg5HkjjdKXAv75
         2V9Gh32C2XqCqG5WlVSzUYfkk3hbWkrgfDcHNX1EediKJJRBqpian51TaB9tj4ABhvMT
         ckfT7LJHkY2uLlTNWl5vYq5z5n1YVK/qXNLXQGYsRmKxtsvDyXg4JISvoxtBgDslz7kS
         IwYDgU5mkqSFOD1iAFJ1eyOSyvGcHVu77vRpDAHJQTtnC5A/+WgHHXXY6MAmg47PTwts
         ouBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769119957; x=1769724757; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Z4UtmHMtrm22Dzvewt+n+aqxxbFiEfZAYYSqL4AsM=;
        b=aIZRSg2AonMg605I5EG0OhwlzBskgYb9wnkW3r1bW1KANF66Gi4OxjMAtyE0HvgceL
         PqVdyf/qRHM0Wt/LHI5Pyu5/VyVV1XA841u4cA6cvkGSD+D5SBS7mcfl5vGrwGZqY2Zr
         IWQFUPLp8/jE6hoqiH4rQpdoJKAWytGEhmoBki1Q9FQM/dj/61twL7369aoB02mWvrhN
         45F5d01+ghCJOTzjc2Mqb02+Q5xtYtFopwqb5OvCHCiSbSIp7bRgRkN5pzAQdolcJEhn
         MrZTvtdacNa6pD31ACMjvtKw5YpJRcELTogbPHXfWQQ3aQ72jymqiW9SbOUoJ2HMWrc+
         oUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769119958; x=1769724758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Z4UtmHMtrm22Dzvewt+n+aqxxbFiEfZAYYSqL4AsM=;
        b=wokaIWYWsTvsml8InTZls+O+rQquPfx70sqI8TdLe3g5WLHBHfRIQtc0EkmeqSeS3G
         gPqxXUDY6glpq/XeAjqbURDJ81kNp3Myjt2eTlMbMszNSq1Pkw6DO1iy+PCW0NKTJpUW
         XCnjzh0oVSNxYjvnTK3+6N6ukLKaSYd6KdmhN7TToxUzZgpzxuLC87vfabcLrQix66Yj
         t1XubEoydIMtwstYsvjYcDV/TCRKTX0vgjbX1jeaF8rtFYCeVuBs2k+SnNk/GOD7fJ9o
         tlCxl/NuAMi3AN+LynEyKYOL2OwBDJltbM2vKVeoQXwl+12JN7r99o/14jD91IY/A1+3
         tQPw==
X-Forwarded-Encrypted: i=1; AJvYcCU90Q3mNnOLFd4Znyimw0n2Y3xllIY4lblho/NhDhGfSgQpAVEa3VC39WYk14VMAnN6y9nJdYy2a6stJ6Yx2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1AP4DqsA24S9bOE3/FMsgBHhzaIuZXD8Q2Qx6vPJ5SeMhl44E
	I0nGz9wmSNv0RFv+NxbO8eXquwrx7w12EQIaX28BofCoKfV1XYpBGlR5v23tco4AVTlnF3mg3yQ
	ylMMJw43UyMPQzdMvKjkH+0kzRBQaG65RS88Lmjws
X-Gm-Gg: AZuq6aLXKuObQfzi1aGOVNZatulTcbNIltOErbShjbZkXqHTb0U4HPEzrgkQZGfsizC
	GA01NFDu4cSn8ehaz+RXIQjffLR8n4victPzgzzGj+DbSw/+QZENZTMaqwJ+07AtelyHBYm6Y7z
	CvuN4bisyAUN4ofzsbfHORJc8r8HgWLXeW+kELXCq5P1r7ryoycA6vNodjCgmALaw7ELWxTK+Gp
	6HkOTGJELRQb2Av1PCB1Lwegi27DWekorf/aGcLY+Vouj4ermGb2KQT0rMeRKrTVW3yLikFd1DT
	8Mep8xTTXurV5x/DViuScPvGOwZdhabWKEs=
X-Received: by 2002:a05:622a:189e:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-502f8db53bbmr1163411cf.5.1769119956786; Thu, 22 Jan 2026
 14:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <43c90424ba0874a71bb7ab9d6423b3a2bf616f8e.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <43c90424ba0874a71bb7ab9d6423b3a2bf616f8e.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 14:12:25 -0800
X-Gm-Features: AZwV_QgEDRlflQAy1nDh25c_dk6-859XJWS6UBtVlFMJyyoqvQVG2qiSotUSCKs
Message-ID: <CAJuCfpEJ0NRB3vgZ2uajGcTRovKYTnrV6woSbFGWZ_LSFerkTA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 10/10] mm/vma: add and use vma_assert_stabilised()
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
> Sometimes we wish to assert that a VMA is stable, that is - the VMA canno=
t
> be changed underneath us. This will be the case if EITHER the VMA lock or
> the mmap lock is held.
>
> In order to do so, we introduce a new assert vma_assert_stablised() - thi=
s

s/vma_assert_stablised/vma_assert_stabilised

> will make a lockdep assert if lockdep is enabled AND the VMA is
> read-locked.
>
> Currently lockdep tracking for VMA write locks is not implemented, so it
> suffices to check in this case that we have either an mmap read or write
> semaphore held.
>
> Note that because the VMA lock uses the non-standard vmlock_dep_map namin=
g
> convention, we cannot use lockdep_assert_is_write_held() so have to open
> code this ourselves via lockdep-asserting that
> lock_is_held_type(&vma->vmlock_dep_map, 0).
>
> We have to be careful here - for instance when merging a VMA, we use the
> mmap write lock to stabilise the examination of adjacent VMAs which might
> be simultaneously VMA read-locked whilst being faulted in.
>
> If we were to assert VMA read lock using lockdep we would encounter an
> incorrect lockdep assert.
>
> Also, we have to be careful about asserting mmap locks are held - if we t=
ry
> to address the above issue by first checking whether mmap lock is held an=
d
> if so asserting it via lockdep, we may find that we were raced by another
> thread acquiring an mmap read lock simultaneously that either we don't
> own (and thus can be released any time - so we are not stable) or was
> indeed released since we last checked.
>
> So to deal with these complexities we end up with either a precise (if
> lockdep is enabled) or imprecise (if not) approach - in the first instanc=
e
> we assert the lock is held using lockdep and thus whether we own it.
>
> If we do own it, then the check is complete, otherwise we must check for
> the VMA read lock being held (VMA write lock implies mmap write lock so t=
he
> mmap lock suffices for this).
>
> If lockdep is not enabled we simply check if the mmap lock is held and ri=
sk
> a false negative (i.e. not asserting when we should do).
>
> There are a couple places in the kernel where we already do this
> stabliisation check - the anon_vma_name() helper in mm/madvise.c and
> vma_flag_set_atomic() in include/linux/mm.h, which we update to use
> vma_assert_stabilised().
>
> This change abstracts these into vma_assert_stabilised(), uses lockdep if
> possible, and avoids a duplicate check of whether the mmap lock is held.
>
> This is also self-documenting and lays the foundations for further VMA
> stability checks in the code.

So, is the lockdep addition the only functional change here?

>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h        |  5 +---
>  include/linux/mmap_lock.h | 52 +++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c              |  4 +--
>  3 files changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6029a71a6908..d7ca837dd8a5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1008,10 +1008,7 @@ static inline void vma_flag_set_atomic(struct vm_a=
rea_struct *vma,
>  {
>         unsigned long *bitmap =3D ACCESS_PRIVATE(&vma->flags, __vma_flags=
);
>
> -       /* mmap read lock/VMA read lock must be held. */
> -       if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> -               vma_assert_locked(vma);
> -
> +       vma_assert_stabilised(vma);
>         if (__vma_flag_atomic_valid(vma, bit))
>                 set_bit((__force int)bit, bitmap);
>  }
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 92ea07f0da4e..e01161560608 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -374,6 +374,52 @@ static inline void vma_assert_locked(struct vm_area_=
struct *vma)
>         vma_assert_write_locked(vma);
>  }
>
> +/**
> + * vma_assert_stabilised() - assert that this VMA cannot be changed from
> + * underneath us either by having a VMA or mmap lock held.
> + * @vma: The VMA whose stability we wish to assess.
> + *
> + * If lockdep is enabled we can precisely ensure stability via either an=
 mmap
> + * lock owned by us or a specific VMA lock.
> + *
> + * With lockdep disabled we may sometimes race with other threads acquir=
ing the
> + * mmap read lock simultaneous with our VMA read lock.
> + */
> +static inline void vma_assert_stabilised(struct vm_area_struct *vma)
> +{
> +       /*
> +        * If another thread owns an mmap lock, it may go away at any tim=
e, and
> +        * thus is no guarantee of stability.
> +        *
> +        * If lockdep is enabled we can accurately determine if an mmap l=
ock is
> +        * held and owned by us. Otherwise we must approximate.
> +        *
> +        * It doesn't necessarily mean we are not stabilised however, as =
we may
> +        * hold a VMA read lock (not a write lock as this would require a=
n owned
> +        * mmap lock).
> +        *
> +        * If (assuming lockdep is not enabled) we were to assert a VMA r=
ead
> +        * lock first we may also run into issues, as other threads can h=
old VMA
> +        * read locks simlutaneous to us.
> +        *
> +        * Therefore if lockdep is not enabled we risk a false negative (=
i.e. no
> +        * assert fired). If accurate checking is required, enable lockde=
p.
> +        */
> +       if (IS_ENABLED(CONFIG_LOCKDEP)) {
> +               if (lockdep_is_held(&vma->vm_mm->mmap_lock))
> +                       return;
> +       } else {
> +               if (rwsem_is_locked(&vma->vm_mm->mmap_lock))
> +                       return;
> +       }
> +
> +       /*
> +        * We're not stabilised by the mmap lock, so assert that we're
> +        * stabilised by a VMA lock.
> +        */
> +       vma_assert_locked(vma);
> +}
> +
>  static inline bool vma_is_attached(struct vm_area_struct *vma)
>  {
>         return refcount_read(&vma->vm_refcnt);
> @@ -455,6 +501,12 @@ static inline void vma_assert_locked(struct vm_area_=
struct *vma)
>         mmap_assert_locked(vma->vm_mm);
>  }
>
> +static inline void vma_assert_stabilised(struct vm_area_struct *vma)
> +{
> +       /* If no VMA locks, then either mmap lock suffices to stabilise. =
*/
> +       mmap_assert_locked(vma->vm_mm);
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4bf4c8c38fd3..1f3040688f04 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -109,9 +109,7 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -       if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> -               vma_assert_locked(vma);
> -
> +       vma_assert_stabilised(vma);
>         return vma->anon_name;
>  }
>
> --
> 2.52.0
