Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD043388848
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110362; cv=pass; b=OESWyu/ebbYuTExg8tHwXxBOvN57LFr4g6np3TQyCWCvbjP8fJWqEzTYq7Oir/UXkfzYP5C7S8P3PrUrsxHksHVV8nRstcPK0Yj6EwUC/YraelpOZ1N3nS2fW6Ia1dfege0kps5PKuw6HiR+QckzK+3jUk7D6NCxpYBgYSfr8TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110362; c=relaxed/simple;
	bh=Fe6CGTHm78f6Ne7PHKCg6iooPD6nWnlZQ0plakVEG8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUbtY6Nlopw9Vb8Fn9gD/bZDgmuEhZUr8yu9KyzzknLl6JGYeOu1Ktxq789OtVparFyuMdpKx2KcOffi/2LbNGGyVLfGKPEGg2pLEiOWiMevNB4S+6VohhsOnyOv96YQEupHdjBz37e4u7LpS8mx9yIQD9j2crYbYV83WglfEUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1c9rUAe; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1c9rUAe"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501511aa012so58181cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 11:32:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110349; cv=none;
        d=google.com; s=arc-20240605;
        b=YYiGBJzOLq1EOipl/Z5MI6XTmIjPikI8om4ZjxiiV1b2y8Xb66J8bKpuaZslVKn3z3
         l7hHCiZx0DjckEznqU1YZIy2SFhr85hCvWpHjLa3vPCi0ctjJ0MWQqoW5vcgd7wiYMpZ
         l3NUh7iD0Jkw/0pXKfvYCEv7cXUVMWc57AUN3udqfF7oKvWB69C6bnfCw4w2UAeRwlqv
         7xvuTM0c7J35QC0B9+GdubgULJiIsWioGAvBu02AA9X2//l3MDWXUWLpBpQWYAQXdw6A
         sMKELW5DImsBNDSNS5BK+OleCQv+r+5VwGmhCL6sdq1Lj5GLwMTRof+rGd74CdSU1wVR
         xJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRanO/ZefSIxQgem+Qjkepyy0HOsMvODV9+whWgkLjs=;
        fh=lOSa44kO68uNOxOqcS9MQzI3jvxdBDavYYoj4wLLjWg=;
        b=b43i36GrBzjr8x+AztyVfdrdw+RDEGd6UglGFr06zndQWTEPiRdwP0HCY/Wga++hfV
         N6LpQ+qfX+lh6k+WIeAvcnbgBjMocPf9iJWkcnu5vnDkT4d53jCJuBbt6ChROmCGizhk
         4fqyUHRFH/TCr//Hqhm8wad/GiUGzk3kR6WRTWEn/Ge/uswhVefijzpXDAWP1cJrbkOn
         sSXvV51CgafYwtFP2ST+HrOjqP33Atz+yG1X7xbhLBirA9ZZBoZB4Dcv5zoOikV5zVUx
         lHkX5yOtWe5s2bzFLNWFwaIZ//Y9bSM5Oi5VO/bm2lKNN7QsCMsgSbBhmxQPk4QsoywC
         Bdzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769110349; x=1769715149; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRanO/ZefSIxQgem+Qjkepyy0HOsMvODV9+whWgkLjs=;
        b=Z1c9rUAe0vNMAzzkXF/zJE4Aas8hmQT9jOEIGuOjcZWlI39aT1eCeFdxIIKkJydxpR
         QkFcZCIR23hv22ASM8xlGYPH170AkNNLraAvkEXH92edmS7ZianD4OfNthCgFUU17zXm
         aPwNPEZ2y4dJ3MBow/YC1WSpBLs3bWfUziSzrKXQYQBsjHuF5Le9TYuZ3Y4qsAPr9RFq
         MywoX0oQ09a818ioz1l9iVMza70LC3+uI5ouTsqa8WerZm3lTvTsnNCfxV17QpUi/SlU
         XdA4nL0KJregZcaxa/zG4FP4l6BZMx5Y0iRIrVGyFyaGECGtVheGcFxmhpG+4XCGvjq0
         iTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110349; x=1769715149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRanO/ZefSIxQgem+Qjkepyy0HOsMvODV9+whWgkLjs=;
        b=BMBuZ3KR9LrlQHTTqp6dM3OlUpM3xTCCawpyyqvDm9S55f16vLLcl0NTEKGWubb1UL
         HCSFNMCp/VF8ng7376UTqKWsUQASiezzGF/zozH90J7CG9YgM1QD0rDiKivWqDqsBMNf
         g+czFDlbtB5/pqiWX3TIUA567QONCnco1CkmR/WARMlgcWLrVrwTXqImKuYACZxH1t7f
         KQSOK9dJFY1hurWW4RzaXh50gFR0go+EZpszPC+RlxhcwZnm9HoceaKKUnmK7CpAFwzm
         Wln/tZX/PI/riNoEVtioJ7fTiqW8v9uBXam3S2oxhRIWeJS1nlohfL8XubL6HK2s4PH7
         l7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVYc2Uh+S1GcxTbzNDUNQyDO/rnb81ayY/d0JXox53XmE/Git4OMsQ6kUR/gMu14MW7YDVd7ZD8fIOG3dbh0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLTLUG62g0r3G/ggCUHmUrM9tTQAsxlEHLCwvK49nNODBUz6jk
	E4vIIkmz7v6fQYFJ8qCSK07H0oV1ZxV6Jb71qiqytGs0NjWvhkRSIew9F0o7IvlEVlgaFb/1jnX
	7nN4ETpeWM4h6Hlw1m1bk45+3uXVcwTC6MP1MLuL+
X-Gm-Gg: AZuq6aLlS9UqIjCyrnKbvbaIeuvksSzPvDabVaRIMW5nXRoHA5um8YRtFyQOKbtp7Gw
	XLFBj9goSQK/df0m7Z98IyskJGwG4ylPI0xwhfdu1kOjzt0uzTsDp1eZOW/QyaWUdr0cb703WM2
	GZpqmskHCRiYaaaHRc4LfDYL2XgWKWE+6LRIPRLzCScsnU1xKUyWPAUbrHAz1yQb28iOzbcGV0T
	4AgGdTgYiwSa3USRDiismDRL7n8dk0HN8zKhk71RU36Cf3hcCXEXrhfle3Y+0ibDPmt2BEdEcxL
	L7qYtBEZoB7+h/F9DOueGMi+
X-Received: by 2002:a05:622a:a64e:b0:4ff:cb72:7c03 with SMTP id
 d75a77b69052e-502f80e7bc2mr1115751cf.3.1769110348822; Thu, 22 Jan 2026
 11:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 11:32:17 -0800
X-Gm-Features: AZwV_QhkpiCkYsJ1sLl0NtsseibW7fpBYNQRixImQz9vEzoC8AsYXBhTYF4fltA
Message-ID: <CAJuCfpG+H=gRSWuhLL=NHQAQzrbF8Jku2qgRHv1moLPRibk5TA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 04/10] mm/vma: add+use vma lockdep
 acquire/release defines
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
> The code is littered with inscrutable and duplicative lockdep incantation=
s,
> replace these with defines which explain what is going on and add
> commentary to explain what we're doing.
>
> If lockdep is disabled these become no-ops. We must use defines so _RET_I=
P_
> remains meaningful.
>
> These are self-documenting and aid readability of the code.
>
> Additionally, instead of using the confusing rwsem_*() form for something
> that is emphatically not an rwsem, we instead explicitly use
> lock_[acquired, release]_shared/exclusive() lockdep invocations since we
> are doing something rather custom here and these make more sense to use.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Very nice! Thank you.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mmap_lock.h | 35 ++++++++++++++++++++++++++++++++---
>  mm/mmap_lock.c            | 10 +++++-----
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0b3614aadbb4..da63b1be6ec0 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -78,6 +78,36 @@ static inline void mmap_assert_write_locked(const stru=
ct mm_struct *mm)
>
>  #ifdef CONFIG_PER_VMA_LOCK
>
> +/*
> + * VMA locks do not behave like most ordinary locks found in the kernel,=
 so we
> + * cannot quite have full lockdep tracking in the way we would ideally p=
refer.
> + *
> + * Read locks act as shared locks which exclude an exclusive lock being
> + * taken. We therefore mark these accordingly on read lock acquire/relea=
se.
> + *
> + * Write locks are acquired exclusively per-VMA, but released in a share=
d
> + * fashion, that is upon vma_end_write_all(), we update the mmap's seqco=
unt such
> + * that write lock is de-acquired.
> + *
> + * We therefore cannot track write locks per-VMA, nor do we try. Mitigat=
ing this
> + * is the fact that, of course, we do lockdep-track the mmap lock rwsem.
> + *
> + * We do, however, want to indicate that during either acquisition of a =
VMA
> + * write lock or detachment of a VMA that we require the lock held be ex=
clusive,
> + * so we utilise lockdep to do so.
> + */
> +#define __vma_lockdep_acquire_read(vma) \
> +       lock_acquire_shared(&vma->vmlock_dep_map, 0, 1, NULL, _RET_IP_)
> +#define __vma_lockdep_release_read(vma) \
> +       lock_release(&vma->vmlock_dep_map, _RET_IP_)
> +#define __vma_lockdep_acquire_exclusive(vma) \
> +       lock_acquire_exclusive(&vma->vmlock_dep_map, 0, 0, NULL, _RET_IP_=
)
> +#define __vma_lockdep_release_exclusive(vma) \
> +       lock_release(&vma->vmlock_dep_map, _RET_IP_)
> +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> +#define __vma_lockdep_stat_mark_acquired(vma) \
> +       lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
>         seqcount_init(&mm->mm_lock_seq);
> @@ -176,8 +206,7 @@ static inline void vma_refcount_put(struct vm_area_st=
ruct *vma)
>         int refcnt;
>         bool detached;
>
> -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> -
> +       __vma_lockdep_release_read(vma);
>         detached =3D __vma_refcount_put(vma, &refcnt);
>         /*
>          * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> @@ -203,7 +232,7 @@ static inline bool vma_start_read_locked_nested(struc=
t vm_area_struct *vma, int
>                                                               VM_REFCNT_L=
IMIT)))
>                 return false;
>
> -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +       __vma_lockdep_acquire_read(vma);
>         return true;
>  }
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index ebacb57e5f16..9563bfb051f4 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -72,7 +72,7 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>         if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt))
>                 return 0;
>
> -       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> +       __vma_lockdep_acquire_exclusive(vma);
>         err =3D rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
>                    state);
> @@ -85,10 +85,10 @@ static inline int __vma_enter_locked(struct vm_area_s=
truct *vma,
>                         WARN_ON_ONCE(!detaching);
>                         err =3D 0;
>                 }
> -               rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> +               __vma_lockdep_release_exclusive(vma);
>                 return err;
>         }
> -       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> +       __vma_lockdep_stat_mark_acquired(vma);
>
>         return 1;
>  }
> @@ -97,7 +97,7 @@ static inline void __vma_exit_locked(struct vm_area_str=
uct *vma, bool *detached)
>  {
>         *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
>                                           &vma->vm_refcnt);
> -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> +       __vma_lockdep_release_exclusive(vma);
>  }
>
>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_s=
eq,
> @@ -199,7 +199,7 @@ static inline struct vm_area_struct *vma_start_read(s=
truct mm_struct *mm,
>                 goto err;
>         }
>
> -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +       __vma_lockdep_acquire_read(vma);
>
>         if (unlikely(vma->vm_mm !=3D mm))
>                 goto err_unstable;
> --
> 2.52.0
