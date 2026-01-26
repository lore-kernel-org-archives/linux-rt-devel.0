Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277113DDAE
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404518; cv=pass; b=tMGq9OKFF7iHOEYfTVupwrTi/nK9eoPESY9Q9o56QwaDkCZKcCJ9FdC9FXW2IOUFTc9b4dLPWJm684pKZTv+zlGM3DvIaFKeTPOqHfWdhCljm+yWTwZe1jma8b95iEiWXgcLXMZNRmy8DqWUDwXbRni7enK6p+XSuUVOmFl5MIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404518; c=relaxed/simple;
	bh=EpyFqIK2ba9pPJFHfV+iMtzXY2XVB0/yR2n+NS1GE5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBkPgLC4W2DdOPkIf1P+ubYw0omnnJP+bUJ10ajQGvasqWb+7dvu1fRFVT9BbkgVs7ewoTCV403uhZOF0MNpztDoZiX4bUtFjYG5QndPdAqEXYwxBfsXJjbopSEUrikm2DfqOC9qQXgTvj795YdCURD3LdipZ1XMxfSjlcavtzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzKI5EXy; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzKI5EXy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014acad6f2so674381cf.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 25 Jan 2026 21:15:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404515; cv=none;
        d=google.com; s=arc-20240605;
        b=dfshMAkeldM1TdvfnxhPohBWcMfjPPlodfprIlJCgCZH42nKjID1AwzHLF9AfccsEu
         2rSVVsFyC5HdEnIVhMO45nggOycccymXrcl7I1UTgunncbhfl97PoIf+GOlPcTh+Kpf4
         cNwbyMHznETcBryIrQIbF/M9pMtTqxlrJvygMwvP2U+V1vdHXgwV4GPghjimGxT7H5kW
         XkH9KGVQzOKy0X5CNaUyVS61+j94n8hmE/gOVGuWLWAItDYn3srTh42kC7qkeiWVmYKX
         +aMYtdWgfdp+bveIfzUm+Alkaem9UAiyXp4S8Vhm8NjChMYFjs9Q2ckW3Pj0k1seldLo
         ZQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mQgKsOGGJe8JvFHFZNpCVI2nLJuIsUEI238/G0I8xU4=;
        fh=3CtEhblhbD27RserPc6LRNgoiWu7oaIsJ2CXW7NfBl8=;
        b=D219Y2ewSAb7/IC9biqTT+llttrEbob5xlyoSaIzt/0esmS7VW6cOyNWwTX3rNwPuS
         SqmkAb/wybG048fswI9CW+/9Ey2jSKAx8CcNhnDey8Buxvu+JkBIkpP2FqO5v5/GltOu
         0PzoZCuBT4iQaAsvba5dq+qGNfyb7LW9m4wdqqWERQyzWRPUsb0fBEKbJDY/hDEHw06Q
         kC4eyMCuRiXoReV33vuHAJjP1MY52eywC572XydbUuutoeTM/MAsQz3nHG8t3sdFyHtH
         PKvTVF/TNqS7n1Jzbf8fsRJzIuw41IyFnE/L0R9ic5K2Ytkt3JduYXfF7CZ5FbsCfBx0
         JLfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769404515; x=1770009315; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQgKsOGGJe8JvFHFZNpCVI2nLJuIsUEI238/G0I8xU4=;
        b=hzKI5EXyP+kgeGqtEwAM7mSIsUAekK+E9wky4rF1dIvsGvoqNVWZqI7nXg93Z4gtn6
         jnsmnHleMTnyJ9GW+G7aXEvZB2MiXRqUsVIiZTwGFVPgW4WfDtRgHR8mdU/8YiRcGRlG
         p5/csAX7pfDKfHueszq2tMZsdHpzQEK+Q1L0smNd8UlwVLvNmHxM/VECR0J0x9NKfuKo
         xaInnUQU/on9Tqw/CS006L9+V98+RYyPoyek4fjLNLuDUhAKBFpdyE9JxeEveMnd9eEr
         siHU8LRu2xQfsvIk+/gltR086u83DJ6t8SuTCUEdVPmzCj3Hea4bm4CF/XKkfzBYPFKA
         IqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404515; x=1770009315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQgKsOGGJe8JvFHFZNpCVI2nLJuIsUEI238/G0I8xU4=;
        b=KL4vLB7CJV1Tw8o1UdgTAWEbFwSXaPcq3uhOs/7bhhPCkPD6GFsS9N+GfgX8wh72bt
         hwPm/RRIV1QNlhTemv/tCyxVLfNGHFGkmsyb8qrasekuReBMyRlWoBG1Y6refD0iRmmG
         MZ3/aYu+echyuEz81BdjdJ6pR9MITzrrmM7XzyflFm5eNPbU3GXwg8ksVEB6GmJt7jUB
         lW01v8BLz+ORbsUul3X6CCQpxQhGwZuHpFeO3dvHVaSLKI2MG7tPQD1c9vDUvEDEtG+Z
         O4U3xePR+sHO0qP8hxnRRpksFgXdpbnRotvaTt7KiFcHE2rp0vlCYN6Ffq212l5pxuZJ
         yUcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpREqFN1KdgztEdDDiWjb6tp0DXCv+DyFtJFK7CFoI12irqDsj9uIWYzFUdn0uzyncxBrFhl4siZIUF4KrJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNiewN+UJOM5Cev7WrnrePOvRn9n1KhcniBgtjV2rqvAcdt09y
	0HHqixIdEL9HDEMHFNj9l7MOOpFUm2o2CqdXV+ECHf68eixxSl+ETvjDIuLrGU5+SyJAgEMn0oI
	GUo4pj142SJZRVzzwzxqAypNd/jsxB6nP3toBKiDO
X-Gm-Gg: AZuq6aLZPLCmw9kBhMMKKtWSb9S9vz4DXz1svTlPz5YMSQikNx6XszdNF48AK7LKM6x
	7xB4bQHNK2z8aujwGUNSVqbifxihvczaiJYJv/yj0hVaCujE1QI8Z/RkqO7mm5V7LH9DWKxFVHK
	tPCIDxXfF1m24G74Ni7bG5jhRJasvkpQ87wenw8xfWM7TtDJSkB01fwP6LlrQvreFT/fqNcTlf1
	8HkIgIFj35KZxRQkzMlAHz7s35awy72ZkQpeAg9DFM+0G4P0yfaaNq9rk+jajt3vqBVcv0ZiD4r
	QQdk
X-Received: by 2002:a05:622a:1:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-5031460c5bbmr7246891cf.18.1769404514989; Sun, 25 Jan 2026
 21:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com> <d462e7678c6cc7461f94e5b26c776547d80a67e8.1769198904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <d462e7678c6cc7461f94e5b26c776547d80a67e8.1769198904.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Jan 2026 21:15:04 -0800
X-Gm-Features: AZwV_Qhs031yzAMqkkSs6ffvEgGLQj1umPZtZRvVLUqCQB2zIzZXYgKDQ0fU6N8
Message-ID: <CAJuCfpEHDVe6==dzb+U5E2Tx_50rH7t1opes8gnzZDP1sKjKhQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] mm/vma: document possible vma->vm_refcnt values
 and reference comment
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
> The possible vma->vm_refcnt values are confusing and vague, explain in
> detail what these can be in a comment describing the vma->vm_refcnt field
> and reference this comment in various places that read/write this field.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

One nit, otherwise LGTM:

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm_types.h  | 42 +++++++++++++++++++++++++++++++++++++--
>  include/linux/mmap_lock.h |  7 +++++++
>  mm/mmap_lock.c            |  6 ++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index bdbf17c4f26b..12281a1128c9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -758,7 +758,8 @@ static inline struct anon_vma_name *anon_vma_name_all=
oc(const char *name)
>   * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indiciate=
 to
>   * vma_start_read() that the reference count should be left alone.
>   *
> - * Once the operation is complete, this value is subtracted from vma->vm=
_refcnt.
> + * See the comment describing vm_refcnt in vm_area_struct for details as=
 to
> + * which values the VMA reference count can be.
>   */
>  #define VM_REFCNT_EXCLUDE_READERS_BIT  (30)
>  #define VM_REFCNT_EXCLUDE_READERS_FLAG (1U << VM_REFCNT_EXCLUDE_READERS_=
BIT)
> @@ -989,7 +990,44 @@ struct vm_area_struct {
>         struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
>  #endif
>  #ifdef CONFIG_PER_VMA_LOCK
> -       /* Unstable RCU readers are allowed to read this. */
> +       /*
> +        * Used to keep track of firstly, whether the VMA is attached, se=
condly,
> +        * if attached, how many read locks are taken, and thirdly, if th=
e
> +        * VM_REFCNT_EXCLUDE_READERS_FLAG is set, whether any read locks =
held
> +        * are currently in the process of being excluded.
> +        *
> +        * This value can be equal to:
> +        *
> +        * 0 - Detached. IMPORTANT: when the refcnt is zero, readers cann=
ot
> +        * increment it.
> +        *
> +        * 1 - Attached and either unlocked or write-locked. Write locks =
are
> +        * identified via __is_vma_write_locked() which checks for equali=
ty of
> +        * vma->vm_lock_seq and mm->mm_lock_seq.
> +        *
> +        * >1, < VM_REFCNT_EXCLUDE_READERS_FLAG - Read-locked or (unlikel=
y)
> +        * write-locked with other threads having temporarily incremented=
 the
> +        * reference count prior to determining it is write-locked and
> +        * decrementing it again.
> +        *
> +        * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
> +        * __vma_exit_locked() completion which will decrement the refere=
nce
> +        * count to zero. IMPORTANT - at this stage no further readers ca=
n
> +        * increment the reference count. It can only be reduced.
> +        *
> +        * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either write-=
locking
> +        * an attached VMA and has yet to invoke __vma_exit_locked(), OR =
a
> +        * thread is detaching a VMA and is waiting on a single spurious =
reader
> +        * in order to decrement the reference count. IMPORTANT - as abov=
e, no
> +        * further readers can increment the reference count.
> +        *
> +        * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either
> +        * write-locking or detaching a VMA is waiting on readers to
> +        * exit. IMPORTANT - as above, no ruther readers can increment th=
e

s/ruther/further

> +        * reference count.
> +        *
> +        * NOTE: Unstable RCU readers are allowed to read this.
> +        */
>         refcount_t vm_refcnt ____cacheline_aligned_in_smp;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map vmlock_dep_map;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 5acbd4ba1b52..a764439d0276 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -130,6 +130,9 @@ static inline bool is_vma_writer_only(int refcnt)
>          * attached. Waiting on a detached vma happens only in
>          * vma_mark_detached() and is a rare case, therefore most of the =
time
>          * there will be no unnecessary wakeup.
> +        *
> +        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> +        * details of possible refcnt values.
>          */
>         return (refcnt & VM_REFCNT_EXCLUDE_READERS_FLAG) &&
>                 refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
> @@ -249,6 +252,10 @@ static inline void vma_assert_locked(struct vm_area_=
struct *vma)
>  {
>         unsigned int mm_lock_seq;
>
> +       /*
> +        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> +        * details of possible refcnt values.
> +        */
>         VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <=3D 1 &&
>                       !__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1d23b48552e9..75dc098aea14 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -65,6 +65,9 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>         /*
>          * If vma is detached then only vma_mark_attached() can raise the
>          * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attac=
hed().
> +        *
> +        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> +        * details of possible refcnt values.
>          */
>         if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt))
>                 return 0;
> @@ -137,6 +140,9 @@ void vma_mark_detached(struct vm_area_struct *vma)
>          * before they check vm_lock_seq, realize the vma is locked and d=
rop
>          * back the vm_refcnt. That is a narrow window for observing a ra=
ised
>          * vm_refcnt.
> +        *
> +        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> +        * details of possible refcnt values.
>          */
>         if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
>                 /* Wait until vma is detached with no readers. */
> --
> 2.52.0
>
