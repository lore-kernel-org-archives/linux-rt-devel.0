Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231D392B91
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110936; cv=pass; b=SKqsxyfH3GIef7XfUwja+AfcNZXYWfs+9tZAZlraSNqcm4otemNdvMjZ1nxACtBQngcQlZQR9NuD23CY9F4Mg5xPIe/k13AgvFxJ6cG8pzHcC7UD+KMNle7LleONNqPyPG2BzzheIBEt7Cq1VqgTpODOWFl7zVq2Ukk82hfg6os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110936; c=relaxed/simple;
	bh=GalaFJ6E3y3j4Fj9kN/sotEBTGsZ0rZYjPbJ+x10+O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFxQcJEz+cS+WDg2VsF8HLADefSIIhYkdIWntoJ3APVy8lahUISg4ftyu/BFj62ncklXWxRqYWtza7V2vQcCKDPbOM4rX4cngtb5HlSHZdYJzzLJTQiWMh/aQlKmin2Kx0qvt9QVYHFwV+RtdJxg49fBoEMP+DD4hPNLSsOlrBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIGl0RJj; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIGl0RJj"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b5d8551so90661cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 11:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110927; cv=none;
        d=google.com; s=arc-20240605;
        b=dRY+2ULAUEPUzyhMVgp4TGg3GGjQvTxF1AgkBoEtWJUZqNTEkKYGkTUFBvQln0Bkbd
         TO+8g2ovoh1BlzsEd2yiy4MSqDDWE59L23h1Hu56fZaLpjFizm8RyX62RQhoWaAlxdAE
         rxc2wBJPTyn+cIoVKUtETTGwYR049l6HxrOYaoUWgU5xO4ixq57jtvWvvBzWJhBhfl7m
         cKIJoYpsbQxsTCCu36F+SnWrwMK2l0UWZ77s7GdjtrIRAA99/TPx6Z92E3t6VRScXJJb
         rJ01GUlOQwAhssS6QWbo5BlHKJjPETs4DHB/3DHOqjC5tkAoF8vVeHvnb1UKDGBJ6SX9
         beGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fDMqkjXmmPWo06N2pnPKq0+6xyOjYYq00iRwl37j1pg=;
        fh=YkYU9qlU5+1aOcm6+DRbtV8gIsqX8ZNNUD5q5/wJYyM=;
        b=ScxearMlo3scmWRzKHlAc11LhtdHRWs7NB3hc0mMUrTEJGegFCY4D6LreuFlDpDGu6
         yLvF+aC3QgAoX4sNLNZl7f8p5DrSmGPRT+v7nfvsWERITtUH8lVkH+yHK5I63PE7S4pP
         07Nfy66dFOmj6nEg2CUBNpV2Avz+Xa2Nw3LkVYu02coTRRi4DVPsmq4no8zi2gBhDxMr
         ovp7E2N7dBJa7hMyObW0xzfP/Us7F2sC/K8S58nWkK2h2+mupGWN1r7JYBbuqlLE/BGF
         yvXTM6aLlMrXHHSbw+svAxetruLqXvsMjkDgOtNx/QC+EBp6TD8PkceVf2S3uE7cRnO0
         mJqg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769110927; x=1769715727; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDMqkjXmmPWo06N2pnPKq0+6xyOjYYq00iRwl37j1pg=;
        b=GIGl0RJjQr9lab4h3c50YK8Ac3AVvg89qv/Ib+q6ANEBIBEsjdaGpIpVRkl7cITsVt
         hsRZsaSZpM4aSYjkjZASWxIaYIWUUPx3TbpAkjhL+H6PNGLmvA0s2KWMiz2QsytbdjMh
         tk8T6U7V4zozp2zzGU5ohiCizvalM5RfB7kmU0RJGQpEulPG5vbyL9griQOF27R1Nf/7
         cb862/ThZIaJwFSbksqQs4WSGSjIlbEo32KiLco5xHSU6oiRzdzcQlvpTFXTdR0+/ulX
         EB2Yo2ivwJ+M4pi2CQaEFMyzRKBS2nvwSAWNOiFo8uMkYsOLq/IShzK7ge1FXUdgbeY8
         L4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110927; x=1769715727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDMqkjXmmPWo06N2pnPKq0+6xyOjYYq00iRwl37j1pg=;
        b=UZZK0VoaALpOw33zLPUp0XM+Zkkf5Vt1TN+1SXZ1ieAsCOfiKGjqRi+HyAzNSVlczq
         Ig5g+MVjFVMfBWW25NzvHNazBvVA6OznaqsHyxo26qa6bXoZxrhFmg0taPHihD9BjBPM
         Qr+6nMbjkO4nHyFIP+lfSDKXDpoOrVXgJ3Rvrr6J8Lc3WJLCFqEgkIwxrgsqlF5R045p
         ZsjOHD+quO4ZBlXr5+HLz4rG/BydIijPmUYBwjuQii/StsJrMIP2yZVHpoRFbRCN40w5
         21wc+GhEoqinY5tOxQEOXMg96SnIszz3fwvWtR+gyg+v89+98jo0abOIkRAal4K96yUO
         44dw==
X-Forwarded-Encrypted: i=1; AJvYcCXl7EvRbubdSgZH7zaXPW3nt6KWv/4v9niyVqJ73t3YEg3iboQIMl5wFmQvVv2r58MSX4G5fMW9qxJrKpL7TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ/RtG7Zk9tgFPc7GMyeA/fcBgIxXQ/FA9u6VAuOPxZ+G/9PVD
	KYR6cJ6B+IP7rf5nD68Ypw1Zs3sXr9wDc6yHjBAxMvmSs71YnKjYYMVr3ffbV8ImYr8k+n7JCOU
	duNkz2WqKcVrTJk14T5mp6qEKKIAz+ECyQQM8Yi77
X-Gm-Gg: AZuq6aIPcqoTgXJRFsTxYlymBKFn5qPLydCRmkQAa/pIAb5TcNIA1CXBynNukvB1RIA
	FN18gfKMlzTU1yHGcy6rgCOt1Tm352yfy7VQMM3u47+EHY0xJ/QGbUlvtm4Z5a/2YyU/DpHNmCe
	I5bt11tqsk79LLEYKNxk81cq0D5Jfawk86DVnuve2ZZmE8SSmEWWdZmTJVVvCJKgrOefs7L+YAc
	FdXnL+E4KYH7aeS2sUSta0ts2t2jcarDvTmf1CHIOmFj244wSGF+h05IQH3EE+yLAaTi3G2HhH5
	CmNTH0Tv5+WkYcW/T4alNcXP
X-Received: by 2002:a05:622a:1189:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-502f80081afmr1484221cf.2.1769110926423; Thu, 22 Jan 2026
 11:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpG+H=gRSWuhLL=NHQAQzrbF8Jku2qgRHv1moLPRibk5TA@mail.gmail.com>
In-Reply-To: <CAJuCfpG+H=gRSWuhLL=NHQAQzrbF8Jku2qgRHv1moLPRibk5TA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 11:41:54 -0800
X-Gm-Features: AZwV_QiG6ERyAk2e30dd4xem0NB6YP41YIG43gNM9PVcgxPRGOqPuE--37BQxdE
Message-ID: <CAJuCfpFVqmHnUVxZZLgeCv7QdPUH3Bv5tM=uOzPWuQgnx2zFvw@mail.gmail.com>
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

On Thu, Jan 22, 2026 at 11:32=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Jan 22, 2026 at 5:02=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > The code is littered with inscrutable and duplicative lockdep incantati=
ons,
> > replace these with defines which explain what is going on and add
> > commentary to explain what we're doing.
> >
> > If lockdep is disabled these become no-ops. We must use defines so _RET=
_IP_
> > remains meaningful.
> >
> > These are self-documenting and aid readability of the code.
> >
> > Additionally, instead of using the confusing rwsem_*() form for somethi=
ng
> > that is emphatically not an rwsem, we instead explicitly use
> > lock_[acquired, release]_shared/exclusive() lockdep invocations since w=
e
> > are doing something rather custom here and these make more sense to use=
.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Very nice! Thank you.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  include/linux/mmap_lock.h | 35 ++++++++++++++++++++++++++++++++---
> >  mm/mmap_lock.c            | 10 +++++-----
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 0b3614aadbb4..da63b1be6ec0 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -78,6 +78,36 @@ static inline void mmap_assert_write_locked(const st=
ruct mm_struct *mm)
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> >
> > +/*
> > + * VMA locks do not behave like most ordinary locks found in the kerne=
l, so we
> > + * cannot quite have full lockdep tracking in the way we would ideally=
 prefer.
> > + *
> > + * Read locks act as shared locks which exclude an exclusive lock bein=
g
> > + * taken. We therefore mark these accordingly on read lock acquire/rel=
ease.
> > + *
> > + * Write locks are acquired exclusively per-VMA, but released in a sha=
red
> > + * fashion, that is upon vma_end_write_all(), we update the mmap's seq=
count such
> > + * that write lock is de-acquired.
> > + *
> > + * We therefore cannot track write locks per-VMA, nor do we try. Mitig=
ating this
> > + * is the fact that, of course, we do lockdep-track the mmap lock rwse=
m.
> > + *
> > + * We do, however, want to indicate that during either acquisition of =
a VMA
> > + * write lock or detachment of a VMA that we require the lock held be =
exclusive,
> > + * so we utilise lockdep to do so.
> > + */
> > +#define __vma_lockdep_acquire_read(vma) \

One question I forgot to ask. Are you adding "__" prefix to indicate
no other users should be using them or for some other reason?

> > +       lock_acquire_shared(&vma->vmlock_dep_map, 0, 1, NULL, _RET_IP_)
> > +#define __vma_lockdep_release_read(vma) \
> > +       lock_release(&vma->vmlock_dep_map, _RET_IP_)
> > +#define __vma_lockdep_acquire_exclusive(vma) \
> > +       lock_acquire_exclusive(&vma->vmlock_dep_map, 0, 0, NULL, _RET_I=
P_)
> > +#define __vma_lockdep_release_exclusive(vma) \
> > +       lock_release(&vma->vmlock_dep_map, _RET_IP_)
> > +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> > +#define __vma_lockdep_stat_mark_acquired(vma) \
> > +       lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> > +
> >  static inline void mm_lock_seqcount_init(struct mm_struct *mm)
> >  {
> >         seqcount_init(&mm->mm_lock_seq);
> > @@ -176,8 +206,7 @@ static inline void vma_refcount_put(struct vm_area_=
struct *vma)
> >         int refcnt;
> >         bool detached;
> >
> > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > -
> > +       __vma_lockdep_release_read(vma);
> >         detached =3D __vma_refcount_put(vma, &refcnt);
> >         /*
> >          * __vma_enter_locked() may be sleeping waiting for readers to =
drop
> > @@ -203,7 +232,7 @@ static inline bool vma_start_read_locked_nested(str=
uct vm_area_struct *vma, int
> >                                                               VM_REFCNT=
_LIMIT)))
> >                 return false;
> >
> > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +       __vma_lockdep_acquire_read(vma);
> >         return true;
> >  }
> >
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index ebacb57e5f16..9563bfb051f4 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -72,7 +72,7 @@ static inline int __vma_enter_locked(struct vm_area_s=
truct *vma,
> >         if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma=
->vm_refcnt))
> >                 return 0;
> >
> > -       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > +       __vma_lockdep_acquire_exclusive(vma);
> >         err =3D rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> >                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
> >                    state);
> > @@ -85,10 +85,10 @@ static inline int __vma_enter_locked(struct vm_area=
_struct *vma,
> >                         WARN_ON_ONCE(!detaching);
> >                         err =3D 0;
> >                 }
> > -               rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > +               __vma_lockdep_release_exclusive(vma);
> >                 return err;
> >         }
> > -       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > +       __vma_lockdep_stat_mark_acquired(vma);
> >
> >         return 1;
> >  }
> > @@ -97,7 +97,7 @@ static inline void __vma_exit_locked(struct vm_area_s=
truct *vma, bool *detached)
> >  {
> >         *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_F=
LAG,
> >                                           &vma->vm_refcnt);
> > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > +       __vma_lockdep_release_exclusive(vma);
> >  }
> >
> >  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock=
_seq,
> > @@ -199,7 +199,7 @@ static inline struct vm_area_struct *vma_start_read=
(struct mm_struct *mm,
> >                 goto err;
> >         }
> >
> > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +       __vma_lockdep_acquire_read(vma);
> >
> >         if (unlikely(vma->vm_mm !=3D mm))
> >                 goto err_unstable;
> > --
> > 2.52.0
