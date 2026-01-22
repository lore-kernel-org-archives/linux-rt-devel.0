Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B953921FD
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109977; cv=pass; b=Rcno7kj5iz6WLGAmD1Usteje6sCtC3nW47W8tRtq2o+bPDFIETzaD1+w1kh3oO327T/dVUvW+LNU0t2pAgkK2LCIOfhQYh/7A7Y/IEAzmW+snAwKIr7BaFrOfmjLjrgzfnEoRuOtq4H5bX+iHRz0YLmeUoxYmEnV+py/1v2XyJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109977; c=relaxed/simple;
	bh=WIBDSV86cKbv/tFL5H8ymz5nfH5UUihdwLcsqwJzbok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auxFTql6sQvBMnQ6ODBLCd2xZiucWD/rXtoTZIh3ZxPHBiXGtumQVPnYBF/f4tV3xDqr505+rTj6WNrGbkeCegiUI1uBE1vd8P22i6LI0PxDM+xrhs5s9V+Pn8Z+a6YwzUmBR8JNScPkr9+mYWwjsLUukuMiPXKVGDHjqRjRBDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgCrer1x; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgCrer1x"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so79251cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 11:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109964; cv=none;
        d=google.com; s=arc-20240605;
        b=dAXO0ZoDM+akdikOPBm2XJsdt/3D8BGRtpRsRY5VXPH0B/buomg2tK2tR0IoB6gbJ8
         5t6JJJIIS/JYRifxLILvCVnOu3CUiTkMfWZ6qmNsgnrUGe+S22VQ7F+U3Ry6Cvy2CveD
         PRdvn+6Twuqe+56jg361cqMLnNBxf2XWo15Eb1UKffCeKWn5U7ItwUqVCe28++1hXVn7
         ubbXzNuS5vQT869P9rxVLWbdmdXIBS6g63oGK4aJEgq7q6QGOVbii5RlaJjcWvs64Hcp
         Ip62R5dmSwWOglEa6UGWXW6We7H4IyRFlHdKt0bE6GHyogJX1eeSHnuwGRVk4b66IOqx
         Obsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFar74v5L9caJGm55iUvf49HTBsbtdcK0qJVDuGPae8=;
        fh=4AVeOtKU73m/Kzjbz8d2Owl3T7+rf6CUAX+hu98Iy9g=;
        b=JQvwZSvPMcB0SEpFer08Y4dOeWPeuqLlqu1xjXufk7fwUx9baQTCIoYtJBBeiu7/Sp
         8uT5320Zlhul9fD4dzdmE/9sI7ZF9NmlaF8mukoUb/WRAA6HhIK2iRw53fD/2LSGdEfh
         Uqkkiky5t4YJeFgsW8lXoP6UZxIDCQgm/TBC+Y3IQh+bB6BZq0q+H4nEHJKFqORJ6QGp
         B78hAb+Zt0dvbm4LC1AqXlaNsV6KG5/UwtstMdrL3yEv+GU7uHbzbZ7Uphij3Xtd4d8G
         AA8C6HHAw6DM/8/0jJtFu8rbBPBxHJFNVCur3ScsI6VBHVnfl9nw5Vf5fn19A9EcfI4L
         ULPg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769109964; x=1769714764; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFar74v5L9caJGm55iUvf49HTBsbtdcK0qJVDuGPae8=;
        b=KgCrer1xdmvy4DXbkkzTXwMEac4ttLFEcXkQvkdLtMi1lm4vXiWbkDRqwkm2dZtZGn
         42hICdvHXHTqrq1k8Z19YwEsiNz4NG4p+U//7YxFGHXfE6gItiYD27f3w2WOK6B2QK+x
         b8FBwFlgQ2rnllyQ1X7kifQRu9/XopCWKZXqhzylFvzrENgsFH7lkEOOFQHbzulTTyZ5
         Eld9HkvGmDjvxmF78Huie5WO7Lf5jKaMMqu6LagrFZrm/UmsEBaBt0sJjaJMrR3ZO4k6
         d274BW3h4seI592NtwvRoR09CoTTYlUajfjYXD/+J4xoYHcXEqRLAUxkUMYlBOw5cBoK
         Gl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109964; x=1769714764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFar74v5L9caJGm55iUvf49HTBsbtdcK0qJVDuGPae8=;
        b=UUnoAVGzknpcyeG4/1z+0g37Dt9EWZftx51fR0ITWTM4+0vULTVRDjEfJTX2mON6W4
         AKQJfRFGPDTVVUiz+RIzv/xKXZteR33AnyC/BILPZ7sHsqdd6v8iay/I1M95jp5GwskV
         Ce2ITpoffUJhbN1ljmriUDdioXSmCF+j6eRkk1BgWqxRCB+kz1uvtzdY0xn4/k8j5EKI
         ouhaxQYtRJnX1bPZZVKlD+t+AXiJtGUwrA8AQsigBNw9RvO1R5Mpsntj7vePKaTdWl2d
         Qntm3BYwd4PmiYPfUpX1K69cylSP79rzzpRbohLFZPlxtfqLG6ad1E1N6bgBemBt+2Jn
         2dwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWccPoA5DMzl+UPWVzr2xVTf7ZZBJle3Kw4460WHeOEe5T4h1tvrYnugJARrpll5tFxH6guQMpZ16NkPrVmNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdwi2FCLTrnfx3ozw8e9wVy/8yObodl2M3E43F8HrpCmJL6O6o
	Asc9+lu0ANr7eo89YwqGJaCK03vt6p+ivepRrGxw7Arn0ncpT84hT2cMvbrvOMVfLGMgx0Hq/lk
	rFE4QPga/0Y5dABaPJ4Ol9Ku5zW56A7ocrrT+Itdk
X-Gm-Gg: AZuq6aLNGnuVBltLg6L3XkBoeqSaBahu7Se+nfS9lhS2H7UY9focz4bfFCFGOQhvVS/
	e8Es1E96T+1KN1EsbgRKLbpATiwWR6YF/9cYfg3zzg/nQTOB3tSuOHfJdBnOoj6Knr0XK9Zm/rw
	VVq5JsroGx6MBR3vDLIWmvik8byh0xAQXiBYmqswwMmqQ0eDXd3ooqv2PM3JMyAhnBFYotsoFhn
	X/W0dUVViGmDX5zZkK9WZ+j64GDIsNqyxhI2FQf+JPAN2+GIpV7Vwg98VKWPuqEYwR6EzsoAj2N
	6I/uLg2SQrjlKzbhy1qIJs/a
X-Received: by 2002:ac8:7c44:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-502f808a608mr1477551cf.14.1769109963495; Thu, 22 Jan 2026
 11:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769085814.git.lorenzo.stoakes@oracle.com> <4703b7320796908b9a0827c3d42d74d11b703714.1769085814.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <4703b7320796908b9a0827c3d42d74d11b703714.1769085814.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 11:25:52 -0800
X-Gm-Features: AZwV_QiC4yCOm_6Ck4ofFpS5FHz68e_QvqRz-MHIzMZU7qBT286p_RXmTzVHZJI
Message-ID: <CAJuCfpFLXtMnO32ffUw91917n22FqFhBRO46BzfOpUe7v_xjPA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mm/vma: add+use vma lockdep acquire/release defines
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
>
