Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5C157480
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451333; cv=pass; b=ttL7h5sNHMWZv+vveXWM+ws2YX7/XF0fLWCBwoHIGmvSPLecQLEC9l4i6tGrQFlXQeS7GWXm3eoahb0zteH7wW2KzJBtM/+8+qXmM3C6cGFyUEpUViDp1FSBbwPYFjzfouLvKRUs/FAUm6SbmNchXrwT3PLb0oybeSzCjUO9PYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451333; c=relaxed/simple;
	bh=4Yb2qUxReqENoX3RoU9yFUjWjFxqDg4V6f1aLynphqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzVYOh2JT+in54i1ITFjFXVhK83VepXvhM4auDvYLM8Yj4R6cJa4/u3xSTNle0KGDL3x/6pvOkRviitmxqCEPyuKTw6hssMlhBoocvxyBhy1n5cv9jrKOp7pFllbwvMf0iml+wqPGF/FX79OmRyilZO8WoZFLZvHyS2LZsh/NFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xEqrTi0+; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xEqrTi0+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501511aa012so24341cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 10:15:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769451331; cv=none;
        d=google.com; s=arc-20240605;
        b=KUWFpcRDYvxdxAzsI4/Zdc514uWN70p4z0aepTb5mreHw4PCKg4jCDnvHzVM/iYreT
         lZ6cpYgCK+T8n8Y0ACpOHnFnaNNpZfVqJwkH4sDIKIlALaIQVegseNjwdEafULgHPZzr
         PEhk4P4qQ1TDQPIT2Y/ebDERoka4oDa4he15AcFZ+9tEEzWzMu/lfNyaica5G9us39H9
         LzEWwzuBB3NhXB2e8ya9JEkKMTFDNV83Q1vd+AbmgNsbxKrJ30UmCN2IznPirS9aena8
         aiC5faV1tNILcZ/itcprTzc6yyNas2sjwxJArAQsnKXETCq315UwHl01faFacuC3MYsM
         UW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vypNXdAlh9xtr/sInNFux3fIr3gyK1o+LAzNlNFXqsw=;
        fh=WDO6JT3P0iF+SGnns3P5NTvqY//sCOmqwDVrIQ5qSVE=;
        b=HzGrU1TJRfhg/vzIhf5mhpFy10F6gaQ1K7r9mlj5j41ds547FzbzKkd+07LUYUvmpO
         8LTPom//JnzfXMnTnUaBqtB6m1XvWBpbRQCI2Pgwlc3ISRO7jbadrdWM9iF/mzi1s3H0
         5D6HiGu5ZYc2MYXT5DdhZ/0XNiiWlziqPbCy0mIWLH4NYJuNJHmGCO68JHTr2j+lSP9c
         myAakf7VP8jQTI2aqnjFwN4Vn3n+/T1FWBuHXhlBZQ0WOxJVcwKclcFVfnjhT7h+nMK9
         Cri9f0qw7xtqURevVn3ezC9LycsS5rTtOc47sK2TBnWRoccUzOjLTEWdlf2Tm2IVOpqa
         Onmg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769451331; x=1770056131; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vypNXdAlh9xtr/sInNFux3fIr3gyK1o+LAzNlNFXqsw=;
        b=xEqrTi0+DB9McyGL6+oJAiMAt88UMyhcXT/xYXy5yAJ2ZttXR4qCXIfkp4/25Yjffn
         WxTgh9QM7WC2UrFTEBVoB0VnjDyp5hDgN/l6cEKQZg5riR6A3rUyftTrvVPKMEZQA33k
         P3nBIWLiAQeiIVKsF4MJ1qTWVzgfs3Z+05+woaG3VBHHm+O7U1JuR7DEP1wWerOiUp6P
         JwrHEBcTyjFljEkFftvayq8lHtAZntcGxeHVmVVfpmOjb0oWm8V+utL3cDgQHZHcGlVR
         ZblC3vDgcdePa+/ZmkZ1EcT05MsFmA9OqQDqrgq1yldSkw1lNx20/gv6M2Ur8a9tDZXW
         5/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769451331; x=1770056131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vypNXdAlh9xtr/sInNFux3fIr3gyK1o+LAzNlNFXqsw=;
        b=OhcUBiLdQicF2zVyP1p9lRRIV1JmW6Y31s5h+Cf0pWJoWPt3xVkl4BF4VAhQxDBkAo
         Hx4DzBm6rlh+71XFUmVglW7es126u2eB9+0RXEvvrRDQmB5YyAdadWGnqrMJsQIG1Py+
         PRKJs7l/XuLW7gdzwpxA7BHf0B1NPvTqOp59RnKgl5w/gnNolOrVqscSqGfUfwyQMqIE
         8ScmLpg2laBV3kGPLHAUnlPja/u/PYV5H1nDlNVGZhIgXwUJJNAgSEL05Ke7w2xhOnXW
         2FoH9P1wn47FTjBS725WKdQYeH1VCAyWTEy2VmlA3IW0eMElKM+zQ0wuQZS3FeelJA9d
         qc5A==
X-Forwarded-Encrypted: i=1; AJvYcCXseKtY+DBwdawO9UDMVlKzVuYwWODV9NcfmMeyxW1eD63AQKRzLikaYu76JukYUhFezUfI5jPyrr9eVTlC/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3sUOO9CisB9GZeEWkEuBEyAInEVa1M78uzDD78qgR4z/3lQLx
	QAHofGt1XF/yB6qUTIeYJ/WPb5FOsZLj/WkWup2OEZiWkRo5p7QO6eEhmbQBv+5IYKfOal45fCb
	/6ysBzq2uYIuw9zq5Jupv+bGl6wqlPq0hFceOYiN7
X-Gm-Gg: AZuq6aJXbTVECuYEdKXiJUqNC89rBXDIrOBej68vrG5x6zdLOcQLBwOqU3Igvu0wRq3
	2ihieN6XMTgr/HX5Ahh1U5BUrPqLg5Yy1nEvOfFWjmLGlOtMyIqMyW56GWX+rGPxNhq3rVlWAJH
	lhJsOdpRo7prh33BrLWX0l74Fi2Vww2FUyydxDTtlNEJBt27z8npvT2gAqN2FxH4iuDmdLBJ+Rf
	d2xWFkpYepqy3sEi0eCDKQNwD4TYZl1dgem+WkRmrrBYyTFZUiht0suJ4hgWNQ8DwIHRQ==
X-Received: by 2002:ac8:7d55:0:b0:502:f1e0:dd3b with SMTP id
 d75a77b69052e-503142fd12bmr14244281cf.7.1769451330395; Mon, 26 Jan 2026
 10:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <7d3084d596c84da10dd374130a5055deba6439c0.1769198904.git.lorenzo.stoakes@oracle.com>
 <ba27d41a-2109-4c89-83ce-00ba8b78d249@suse.cz>
In-Reply-To: <ba27d41a-2109-4c89-83ce-00ba8b78d249@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Jan 2026 10:15:19 -0800
X-Gm-Features: AZwV_QgyKFOWHTjmvluDsVSs8ymtZTUXuwqayAi8HRabjZVKe2RBfgyVhhCTGtQ
Message-ID: <CAJuCfpEkmMT9Bi6=46pvpezb3xMNnJgEKdKSQEm6Ky=Ygb2hAw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] mm/vma: introduce helper struct + thread through
 exclusive lock fns
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:16=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/23/26 21:12, Lorenzo Stoakes wrote:
> > It is confusing to have __vma_enter_exclusive_locked() return 0, 1 or a=
n
>
> It's now __vma_start_exclude_readers()
>
> > error (but only when waiting for readers in TASK_KILLABLE state), and
> > having the return value be stored in a stack variable called 'locked' i=
s
> > further confusion.
> >
> > More generally, we are doing a lock of rather finnicky things during th=
e
>
>                                  ^ lot?
>
> > acquisition of a state in which readers are excluded and moving out of =
this
> > state, including tracking whether we are detached or not or whether an
> > error occurred.
> >
> > We are implementing logic in __vma_enter_exclusive_locked() that
>
> again __vma_start_exclude_readers()
>
> > effectively acts as if 'if one caller calls us do X, if another then do=
 Y',
> > which is very confusing from a control flow perspective.
> >
> > Introducing the shared helper object state helps us avoid this, as we c=
an
> > now handle the 'an error arose but we're detached' condition correctly =
in
> > both callers - a warning if not detaching, and treating the situation a=
s if
> > no error arose in the case of a VMA detaching.
> >
> > This also acts to help document what's going on and allows us to add so=
me
> > more logical debug asserts.
> >
> > Also update vma_mark_detached() to add a guard clause for the likely
> > 'already detached' state (given we hold the mmap write lock), and add a
> > comment about ephemeral VMA read lock reference count increments to cla=
rify
> > why we are entering/exiting an exclusive locked state here.
> >
> > Finally, separate vma_mark_detached() into its fast-path component and =
make
> > it inline, then place the slow path for excluding readers in mmap_lock.=
c.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

With Vlastimil's nits fixed,

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Great improvement, thanks.

Indeed, looks very clean now. Thanks!

>
> Just some more nits wrt naming.
>
> > ---
> >  include/linux/mm_types.h  |  14 ++--
> >  include/linux/mmap_lock.h |  23 +++++-
> >  mm/mmap_lock.c            | 152 +++++++++++++++++++++-----------------
> >  3 files changed, 112 insertions(+), 77 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 12281a1128c9..ca47a5d3d71e 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1011,15 +1011,15 @@ struct vm_area_struct {
> >        * decrementing it again.
> >        *
> >        * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
> > -      * __vma_exit_locked() completion which will decrement the refere=
nce
> > -      * count to zero. IMPORTANT - at this stage no further readers ca=
n
> > -      * increment the reference count. It can only be reduced.
> > +      * __vma_exit_exclusive_locked() completion which will decrement =
the
>
> __vma_end_exclude_readers()
>
> > +      * reference count to zero. IMPORTANT - at this stage no further =
readers
> > +      * can increment the reference count. It can only be reduced.
> >        *
> >        * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either write-=
locking
> > -      * an attached VMA and has yet to invoke __vma_exit_locked(), OR =
a
> > -      * thread is detaching a VMA and is waiting on a single spurious =
reader
> > -      * in order to decrement the reference count. IMPORTANT - as abov=
e, no
> > -      * further readers can increment the reference count.
> > +      * an attached VMA and has yet to invoke __vma_exit_exclusive_loc=
ked(),
>
> __vma_end_exclude_readers()
>
> (also strictly speaking, these would belong to the previous patch, but no=
t
> worth the trouble moving)
>
> > +      * OR a thread is detaching a VMA and is waiting on a single spur=
ious
> > +      * reader in order to decrement the reference count. IMPORTANT - =
as
> > +      * above, no further readers can increment the reference count.
> >        *
> >        * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - A thread is either
> >        * write-locking or detaching a VMA is waiting on readers to
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index d6df6aad3e24..678f90080fa6 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -358,7 +358,28 @@ static inline void vma_mark_attached(struct vm_are=
a_struct *vma)
> >       refcount_set_release(&vma->vm_refcnt, 1);
> >  }
> >
> > -void vma_mark_detached(struct vm_area_struct *vma);
> > +void __vma_exclude_readers_for_detach(struct vm_area_struct *vma);
> > +
> > +static inline void vma_mark_detached(struct vm_area_struct *vma)
> > +{
> > +     vma_assert_write_locked(vma);
> > +     vma_assert_attached(vma);
> > +
> > +     /*
> > +      * The VMA still being attached (refcnt > 0) - is unlikely, becau=
se the
> > +      * vma has been already write-locked and readers can increment vm=
_refcnt
> > +      * only temporarily before they check vm_lock_seq, realize the vm=
a is
> > +      * locked and drop back the vm_refcnt. That is a narrow window fo=
r
> > +      * observing a raised vm_refcnt.
> > +      *
> > +      * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> > +      * details of possible refcnt values.
> > +      */
> > +     if (likely(!__vma_refcount_put_return(vma)))
> > +             return;
> > +
> > +     __vma_exclude_readers_for_detach(vma);
> > +}
> >
> >  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >                                         unsigned long address);
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 72f15f606093..b523a3fe110c 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -46,20 +46,38 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> >  #ifdef CONFIG_MMU
> >  #ifdef CONFIG_PER_VMA_LOCK
> >
> > +/* State shared across __vma_[enter, exit]_exclusive_locked(). */
>
> __vma_[start,end]_exclude_readers
>
> > +struct vma_exclude_readers_state {
> > +     /* Input parameters. */
> > +     struct vm_area_struct *vma;
> > +     int state; /* TASK_KILLABLE or TASK_UNINTERRUPTIBLE. */
> > +     bool detaching;
> > +
> > +     /* Output parameters. */
> > +     bool detached;
> > +     bool exclusive; /* Are we exclusively locked? */
> > +};
> > +
> >  /*
> >   * Now that all readers have been evicted, mark the VMA as being out o=
f the
> >   * 'exclude readers' state.
> > - *
> > - * Returns true if the VMA is now detached, otherwise false.
> >   */
> > -static bool __must_check __vma_end_exclude_readers(struct vm_area_stru=
ct *vma)
> > +static void __vma_end_exclude_readers(struct vma_exclude_readers_state=
 *ves)
> >  {
> > -     bool detached;
> > +     struct vm_area_struct *vma =3D ves->vma;
> >
> > -     detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG=
,
> > -                                      &vma->vm_refcnt);
> > +     VM_WARN_ON_ONCE(ves->detached);
> > +
> > +     ves->detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS=
_FLAG,
> > +                                           &vma->vm_refcnt);
> >       __vma_lockdep_release_exclusive(vma);
> > -     return detached;
> > +}
> > +
> > +static unsigned int get_target_refcnt(struct vma_exclude_readers_state=
 *ves)
> > +{
> > +     const unsigned int tgt =3D ves->detaching ? 0 : 1;
> > +
> > +     return tgt | VM_REFCNT_EXCLUDE_READERS_FLAG;
> >  }
> >
> >  /*
> > @@ -69,32 +87,29 @@ static bool __must_check __vma_end_exclude_readers(=
struct vm_area_struct *vma)
> >   * Note that this function pairs with vma_refcount_put() which will wa=
ke up this
> >   * thread when it detects that the last reader has released its lock.
> >   *
> > - * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in case=
s where we
> > - * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fata=
l signal
> > - * is permitted to kill it.
> > + * The ves->state parameter ought to be set to TASK_UNINTERRUPTIBLE in=
 cases
> > + * where we wish the thread to sleep uninterruptibly or TASK_KILLABLE =
if a fatal
> > + * signal is permitted to kill it.
> >   *
> > - * The function will return 0 immediately if the VMA is detached, or w=
ait for
> > - * readers and return 1 once they have all exited, leaving the VMA exc=
lusively
> > - * locked.
> > + * The function sets the ves->exclusive parameter to true if readers w=
ere
> > + * excluded, or false if the VMA was detached or an error arose on wai=
t.
> >   *
> > - * If the function returns 1, the caller is required to invoke
> > - * __vma_end_exclude_readers() once the exclusive state is no longer r=
equired.
> > + * If the function indicates an exclusive lock was acquired via ves->e=
xclusive
> > + * the caller is required to invoke __vma_end_exclude_readers() once t=
he
> > + * exclusive state is no longer required.
> >   *
> > - * If state is set to something other than TASK_UNINTERRUPTIBLE, the f=
unction
> > - * may also return -EINTR to indicate a fatal signal was received whil=
e waiting.
> > + * If ves->state is set to something other than TASK_UNINTERRUPTIBLE, =
the
> > + * function may also return -EINTR to indicate a fatal signal was rece=
ived while
> > + * waiting.
>
> It says "may also return..." but now doesn't say anywhere that otherwise
> it's always 0.
>
> >   */
> > -static int __vma_start_exclude_readers(struct vm_area_struct *vma,
> > -             bool detaching, int state)
> > +static int __vma_start_exclude_readers(struct vma_exclude_readers_stat=
e *ves)
