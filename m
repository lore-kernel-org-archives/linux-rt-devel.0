Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39F3D7D9D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099895; cv=pass; b=JI2s8/aSqvflwx+9xY01vhM//jE7Jk2/r0osgUFRgJlLmmGXRJbrt2ByV/iQVaW2YKRhInNAYnJMjWYeFrXm0gxd8kC3lrp4jghBgxJRTXX9yf4bbmJJp4qrdSOPRmvYHcBoX3Lh8L2N/5HphgizxdmDXKi8tTzmZ0iLXSA+4uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099895; c=relaxed/simple;
	bh=qhPe47+jYlD5tvGsS1mfp3GfB77c+u4NhZIxcWeufwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEaSi+L8B5itxwFXqPOpi3aVCs7X1pCzc75RTeNEFv0AoA8SGKsuwvc5Nu+0WH33zQy557wiIY0QYxQX0GzSG0RpzI4D3UkFKrmGPywlcXfwE3fING9kt94mhgEyrmUTzbnf01OkKaDtdrvEnYHvQM+uyCKXk5roiUSF6NdzrA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSpiXn/d; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSpiXn/d"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501511aa012so441751cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 08:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769099882; cv=none;
        d=google.com; s=arc-20240605;
        b=KbbaQ4eQkWHuP+NwoSxrKzDk771nj1+W/5nqlUXaGOvgZdNzYJtKMabcF/LLYZ4Qlc
         AIwqiWhQtmpfJDWkB7Ba7irvTPXugrq3wOO/bFrlkyqIkssT4cgp8kode0SbEimx+6Hj
         /7Um2mGMKZTxHs775p8hAsZ0Wwv7LC9Xsqy+TjCOvK1TxCSUXxeWwk9k6K6KoKxbTn3b
         vU5X1GCn+Q/H7GD5eUwzCB864erZfBUvzM02mVgFj+5ZyWxguAqYiepEGY7bHRhgr666
         tl9r5R8otUA6Kj2XpDGbmUBhrlrN+HoyEPU9xQDspce+v9saanNLzJ/q7n5xCn5GlQat
         1JXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C+XJNVYw8jPN2hJXKO6Gd31AsDaPUTQQW1O2H2Pw33g=;
        fh=Ev1Eop4sFNk3T1+MbsDuTXOQIsPWosI868QuoiaxKnw=;
        b=V9mr1ju/kzI+6drSC6Hgvc5KAlKTBQWuMEhTKiLzKgAIJzzR61XS2OtlaTAN7VfLq8
         XU/b+g/vCxtkqalPGgtHTJQs91Rfyj/c+kYQ02HDl3i/fHocPaXCTAKpDlo37uggHXHF
         N9R0KZL18crPnYxJ8oikymMvRknIOV9416LHhVXipkLd0gEVYbEootAQaS5k6+9y9xeF
         v3xr+QX0nJhMYNTrkfhJsGgj/gc3XtBkP0An0spdGKRNW2U6ezIDhi2Ucn1JOWqWVIdg
         +oTnq/EObY0WdWIsIECMX3281QhO9/v4lOxX7iKS6zjlVmK8HZyBDdl/BgyTpQwWrSTM
         mYtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769099882; x=1769704682; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+XJNVYw8jPN2hJXKO6Gd31AsDaPUTQQW1O2H2Pw33g=;
        b=eSpiXn/dQSyX6DBiMLTL+18NcfMNK072e1s7V4FH74YKWGrXbDiKr8PA1fOeCdR9Gh
         l0aAd3A95ceo4S1SDRDMk09DsAjGl7JsEu3C0o8sx0dL83ZbsZpwMizybL65dR3sRShG
         TWWBLn1eEY94FJhrviINVsnhV0ZdWC0UDW8tfl2hA1b53wvBocwKmNIm5Mr8saGZQX2F
         0m4WWFKPHxQfQwQtAzlo41K1F7tbnZwrfcP+5RhiVzh7UsTyzl+MZRzdyXnIdv59S+AV
         vgFOySAJeIXPK++zlvv5JccEgNspfiMap4SAlr+zSSWfhepqjO7t7Q6MS9crwemCWAtG
         jS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099882; x=1769704682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+XJNVYw8jPN2hJXKO6Gd31AsDaPUTQQW1O2H2Pw33g=;
        b=N8H9eElbWAAzpubclBkpkjUEXx1OFsLyf/B/etbKJQWamTOCID6V3PkgR1LSGcPYGm
         0ppqUW+f0MY3qGeLM0ohjH2F20VT337Ub9hSMDHzyKqVTbzFpZsAiByLlTmRpM+eIwA0
         MV1ELAvs7qNvqsZO8C9uWRmTdd7+M+NszZihiP4E/RXnYKsWf9NUDj3kkv0zg26b76lG
         8nl6CedoVhY7RxPb7N5nYk/y2jAg0GTg+et7+w9coLdhurxgRrp3VA1YIrQJiCLZejky
         f9oRHGgIDzW1yRuGqEK81Y9e3/+Ku6YtmQ3RTQCbv1rA57kOJimhxY38hJHEg3FpAbd5
         aEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUWVQE0A0l5ElAdVZibdwMvOeBY9iQ5zWhtPCeznUI2wir4voERMAcC4uU229tAd98lr0GrV5qd40vhHR56cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSYuFzVao8b1734GuPTH9KWNY4VmJvc7hD5EhNcVhNf4vG/mZl
	icMX+Y82II8Y9MG3F0HW9IPgwK8e9iaRjr58sJV0c2Px9eaSJUP2GjMQCOZ5AZPEI04upNKedyd
	CrbEAjLgHiBqu8WA60XPXTiP8ssI1CNCF84DBCIZg
X-Gm-Gg: AZuq6aLzGbsH8w+6/nt1ynVASocWEtv0Lw6OXCyC9FfKMl3Z+4axuvZKfPm4kiUslFj
	sYL7YLJhC/ko2TWSezycZgMPG8tyM/CjX56j5k6tIUkiB1OTmxb1rhDRm9CX/BzwnwIQqr/9UNq
	nXBDQm8i/bPePbtIF2rY0JjskDPHRx+NqK124CzMPRILcM7OgkSzvgDRlWEJPWb8Zg+HpNvrr70
	W/hXA415zMZAuVukguzfOqvEB7McKjvCPJ2v/8stvQYpm03Wqh5Y4l676wNq8GE7RnkrlEOg/6q
	sVvMQlat0H416nur+SarA0/Wf6uRppvF5qE=
X-Received: by 2002:a05:622a:994:b0:4ff:bf96:db86 with SMTP id
 d75a77b69052e-502ebd89420mr15849671cf.16.1769099882208; Thu, 22 Jan 2026
 08:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <f637c1a5c9ea237aab598bd8885df48e21497635.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f637c1a5c9ea237aab598bd8885df48e21497635.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 08:37:51 -0800
X-Gm-Features: AZwV_Qi1sC3YuQM_mL6DhJMjvyalsazWO_0hCWyLwAGLVG52aYT7kPHUYQhat78
Message-ID: <CAJuCfpH-07KqsgLsFoBXjObMakVxb+w8w_UmZi9TTxCEzmaA0g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 01/10] mm/vma: rename VMA_LOCK_OFFSET to VM_REFCNT_EXCLUDE_READERS_FLAG
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
> The VMA_LOCK_OFFSET value encodes a flag which vma->vm_refcnt is set to i=
n
> order to indicate that a VMA is in the process of having VMA read-locks
> excluded in __vma_enter_locked() (that is, first checking if there are an=
y
> VMA read locks held, and if there are, waiting on them to be released).
>
> This happens when a VMA write lock is being established, or a VMA is bein=
g
> marked detached and discovers that the VMA reference count is elevated du=
e
> to read-locks temporarily elevating the reference count only to discover =
a
> VMA write lock is in place.
>
> The naming does not convey any of this, so rename VMA_LOCK_OFFSET to
> VM_REFCNT_EXCLUDE_READERS_FLAG (with a sensible new prefix to differentia=
te
> from the newly introduced VMA_*_BIT flags).
>
> Also rename VMA_REF_LIMIT to VM_REFCNT_LIMIT to make this consistent also=
.
>
> Update comments to reflect this.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for the cleanup Lorenzo, and sorry for the delay in reviewing
your patches. I finally have some time and will try to finish my
review today.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm_types.h  | 17 +++++++++++++----
>  include/linux/mmap_lock.h | 14 ++++++++------
>  mm/mmap_lock.c            | 17 ++++++++++-------
>  3 files changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 78950eb8926d..94de392ed3c5 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -752,8 +752,17 @@ static inline struct anon_vma_name *anon_vma_name_al=
loc(const char *name)
>  }
>  #endif
>
> -#define VMA_LOCK_OFFSET        0x40000000
> -#define VMA_REF_LIMIT  (VMA_LOCK_OFFSET - 1)
> +/*
> + * WHile __vma_enter_locked() is working to ensure are no read-locks hel=
d on a

s/WHile/While

> + * VMA (either while acquiring a VMA write lock or marking a VMA detache=
d) we
> + * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indiciate=
 to
> + * vma_start_read() that the reference count should be left alone.
> + *
> + * Once the operation is complete, this value is subtracted from vma->vm=
_refcnt.
> + */
> +#define VM_REFCNT_EXCLUDE_READERS_BIT  (30)
> +#define VM_REFCNT_EXCLUDE_READERS_FLAG (1U << VM_REFCNT_EXCLUDE_READERS_=
BIT)
> +#define VM_REFCNT_LIMIT                        (VM_REFCNT_EXCLUDE_READER=
S_FLAG - 1)
>
>  struct vma_numab_state {
>         /*
> @@ -935,10 +944,10 @@ struct vm_area_struct {
>         /*
>          * Can only be written (using WRITE_ONCE()) while holding both:
>          *  - mmap_lock (in write mode)
> -        *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
> +        *  - vm_refcnt bit at VM_REFCNT_EXCLUDE_READERS_FLAG is set
>          * Can be read reliably while holding one of:
>          *  - mmap_lock (in read or write mode)
> -        *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
> +        *  - vm_refcnt bit at VM_REFCNT_EXCLUDE_READERS_BIT is set or vm=
_refcnt > 1
>          * Can be read unreliably (using READ_ONCE()) for pessimistic bai=
lout
>          * while holding nothing (except RCU to keep the VMA struct alloc=
ated).
>          *
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index b50416fbba20..5acbd4ba1b52 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -125,12 +125,14 @@ static inline void vma_lock_init(struct vm_area_str=
uct *vma, bool reset_refcnt)
>  static inline bool is_vma_writer_only(int refcnt)
>  {
>         /*
> -        * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the=
 vma
> -        * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiti=
ng on
> -        * a detached vma happens only in vma_mark_detached() and is a ra=
re
> -        * case, therefore most of the time there will be no unnecessary =
wakeup.
> +        * With a writer and no readers, refcnt is VM_REFCNT_EXCLUDE_READ=
ERS_FLAG
> +        * if the vma is detached and (VM_REFCNT_EXCLUDE_READERS_FLAG + 1=
) if it is
> +        * attached. Waiting on a detached vma happens only in
> +        * vma_mark_detached() and is a rare case, therefore most of the =
time
> +        * there will be no unnecessary wakeup.
>          */
> -       return (refcnt & VMA_LOCK_OFFSET) && refcnt <=3D VMA_LOCK_OFFSET =
+ 1;
> +       return (refcnt & VM_REFCNT_EXCLUDE_READERS_FLAG) &&
> +               refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
>  }
>
>  static inline void vma_refcount_put(struct vm_area_struct *vma)
> @@ -159,7 +161,7 @@ static inline bool vma_start_read_locked_nested(struc=
t vm_area_struct *vma, int
>
>         mmap_assert_locked(vma->vm_mm);
>         if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_re=
fcnt, &oldcnt,
> -                                                             VMA_REF_LIM=
IT)))
> +                                                             VM_REFCNT_L=
IMIT)))
>                 return false;
>
>         rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 7421b7ea8001..1d23b48552e9 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -54,7 +54,7 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>                 bool detaching, int state)
>  {
>         int err;
> -       unsigned int tgt_refcnt =3D VMA_LOCK_OFFSET;
> +       unsigned int tgt_refcnt =3D VM_REFCNT_EXCLUDE_READERS_FLAG;
>
>         mmap_assert_write_locked(vma->vm_mm);
>
> @@ -66,7 +66,7 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>          * If vma is detached then only vma_mark_attached() can raise the
>          * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attac=
hed().
>          */
> -       if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
> +       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt))
>                 return 0;
>
>         rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> @@ -74,7 +74,7 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
>                    state);
>         if (err) {
> -               if (refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcn=
t)) {
> +               if (refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,=
 &vma->vm_refcnt)) {
>                         /*
>                          * The wait failed, but the last reader went away
>                          * as well.  Tell the caller the VMA is detached.
> @@ -92,7 +92,8 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>
>  static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *d=
etached)
>  {
> -       *detached =3D refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_ref=
cnt);
> +       *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
> +                                         &vma->vm_refcnt);
>         rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
>  }
>
> @@ -180,13 +181,15 @@ static inline struct vm_area_struct *vma_start_read=
(struct mm_struct *mm,
>         }
>
>         /*
> -        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acq=
uire()
> -        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> +        * If VM_REFCNT_EXCLUDE_READERS_FLAG is set,
> +        * __refcount_inc_not_zero_limited_acquire() will fail because
> +        * VM_REFCNT_LIMIT is less than VM_REFCNT_EXCLUDE_READERS_FLAG.
> +        *
>          * Acquire fence is required here to avoid reordering against lat=
er
>          * vm_lock_seq check and checks inside lock_vma_under_rcu().
>          */
>         if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_re=
fcnt, &oldcnt,
> -                                                             VMA_REF_LIM=
IT))) {
> +                                                             VM_REFCNT_L=
IMIT))) {
>                 /* return EAGAIN if vma got detached from under us */
>                 vma =3D oldcnt ? NULL : ERR_PTR(-EAGAIN);
>                 goto err;
> --
> 2.52.0
