Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85429CE9
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406473; cv=pass; b=tIIftPCD/PSahUQDd4ItWPX/FSrwzrbLDBxbqdQBHsuk503Ut+ow6VXKS5BtsDyCUg4P0z2Ub7a9fHLKTmafx+I9lMauf2TIAexYNvUE1//VZp9TiVEtoCso6m2ST2ooJJg+rMJgUDNjMeXTMEuYcDW9ZUXKl04ErK2KKLzZXgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406473; c=relaxed/simple;
	bh=KZmBQCivZigW+FXU0a2KVhAffYvS5wlBbbcHEDyWJQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDZNXrB0I2T0RDWPL30mOpQIMRhwo4QYpio75dyW/HnXEXY3JgfmQnIEk3wju7SurUWlPkDYGthh1+AIQ2QV5tmLsW9TyswUENgNPAeb3+BKykeLAuMz2YBtIZOQkVyaWcZZsy4mc0tf0NFIYDi0sSHWFb106KcjKkpDJgLnJ7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zig4AIru; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zig4AIru"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014acad6f2so686421cf.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 25 Jan 2026 21:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769406470; cv=none;
        d=google.com; s=arc-20240605;
        b=E+BNlYQs6WyhxtqCfi5495XmGqy8X03kPEDatSXIbhNMeHOUzDuKFHZLD5fz8Ubvke
         BE59wk06kJLFiGj/td5TUAFxt/p18wdN2OTJmcPLxa64Fx2VT7ElQPCiT1c70/TtM57m
         GgHuNQKqugYZMpHlpL3QPcy9gknlEFXMZfosbpd33h06aNPHKMhS2TO5Q7ShyBhQQ5gF
         0Wiea4VabTWJRFahLBw77oYocHdzv9kncuKss5y3ebxbMKYV0NPX/a9mBXx8JyGkiJua
         DjZHyWQNB18057nQq9RVjTuAbjyNm9nePd3J/nyRsG29lF3bW9PZleTGf2dlLdDrLgJd
         Xr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ono5wEe1osDw2iE22hQcZURKz2YR0r2QKp0J45Nys8Y=;
        fh=U2OcHj4c5XEWakPA1fm5J5eJpGgG3HDs0+kn6fqjjEs=;
        b=bPgP8QTqov5WmZ1PdvGzvy9z8lECRAY6Vt1YY+r0i1hZnCcIs1rJWT8b4sTO7tmda1
         7eV2ARVn/sBRTsB4J0tlAbBvHhEcUbMzTJCn+LkoeJVIneFJgIlKrbT4y+1gRzQMl7tI
         7Mt/DZxw1rPQtja1X07UlB4BWInxgBAY1InqD2pxXvHb30PATvtoqcnGGeHz3gB8cYKH
         /lcIhGUqEL0tZt4pTFyTAV6jLbkzHir5FcK7RSI9pddcRZSnCq6vCRkGrBBMlcvHaR8J
         TV0jT611pXNx/D2893dyOZXmXe5UP+DBT4GFK0vL3oc9yd6ksRAIbFNhv1z8vK7z3Jjt
         NuKQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769406470; x=1770011270; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ono5wEe1osDw2iE22hQcZURKz2YR0r2QKp0J45Nys8Y=;
        b=Zig4AIruydMEXdDbhtw8pX587JhmHn7S1ez58S/OK6vLBlbb2IUldHjzL59WttaFcH
         kmu/cQtq9nzD2Bb1+wxBrdsKQw6bEWJRx/GuciyBZGOCdRnsNILYKFK30HMbs2bztkdZ
         8U2pwSVum2R+ckpg5hRwelEjgBFTsz7TqRYZvcfCPoFHE7bIn/5I9TmmDRGVOQNk6tF1
         OubNLOqWIHR9m2yAf7n/x8z2TzDD1lOxrwfADqStsY/oQFFb0lkP+pNQGlg35+Wpi0JM
         26Dv+3p+dF+/c/cfoTYmcDStEkbDyKNst/p+SJL6vSNjPyO9+o5UYMkHUQP48036PEIM
         Hv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769406470; x=1770011270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ono5wEe1osDw2iE22hQcZURKz2YR0r2QKp0J45Nys8Y=;
        b=VaXarrUyMuJSEpdmgNYQcrZV0wJbuqoEoc52PZ3HZox8iq/fWSzBJ6QjKRa/mOJKPe
         H6BW88Pu9PcY21zDG0RkKlpMonFowePZRZCvxjz/ceQRSDqGhpJDU/IjA6NorqffSY7t
         ZngeaEZ+K276yhiFYCVJ179fXr7V85qeIDgfpsDwj4MH27nHbtDxdSbxuhW4T4hNLXEG
         gGh3o1nMhSTOZdMVgQWSo3Bk9pU80B1qq/M/1R/OdjuzW8shoIxtPRe5HpFM8pyLNx4y
         2CK9TemY9XDjLt7sFaGa+QkffbdqeeFbcveVzBS5J6GEWBi0TOMnxLse4D7hMiPhXM/O
         kUuA==
X-Forwarded-Encrypted: i=1; AJvYcCX2MwplJb4/fjQTsRwCqSrLPOXHMo6sHfHPb/ZHakzY8I72bgqT5ecSTXfF3j9Z5qp1mtjWNzwY2yHqo9a5SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmBK0GxY+iYHzvjO4RB0l3ZSFaSId6ocu2t8CwIaSTzWfjRrg5
	M+EPeCnjn9Lwf+RvTwrPbhKcsQOMucClO1MSX5P1FA4d5A7/Gg+czrR1eYfDQV068TTQ7vFgLwf
	LuP1cOI9ich8equHh0ErQ+nNO0ZQUG475ZtKhNSTq
X-Gm-Gg: AZuq6aJMWtseZb/BWLLSYgEOBIaNPnmYUeq7y0kyYt1SU2SVJfuIsPHxGVboIQf146z
	OaVVFx5K6qxeBafE5TOowLyCv3pT0a2+Zuf/rWwE06sTxzCvO8gJ6SU+hb3S8pVwHsrrJpUNmW0
	VzvSeiIz098G/KPjHrq7Bwug5sJ47AL1NyXcz/NP8JRmUXRyStCK+WTvYEvh2OY4cI+pG5dgghB
	HMIJtIu9u965mXgr6GdnPlNi0qnxFbn57PSrUInUo6Bo+OPhUiUnsLLr/a1c5GGMt+wdAEoR9e+
	d3aa
X-Received: by 2002:ac8:57cd:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-5031430a8b7mr7932911cf.8.1769406469898; Sun, 25 Jan 2026
 21:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com> <33273be9389712347d69987c408ca7436f0c1b22.1769198904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <33273be9389712347d69987c408ca7436f0c1b22.1769198904.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Jan 2026 21:47:38 -0800
X-Gm-Features: AZwV_QgbHT43t7haH8iPqdCJ4GlQ7FA-MKST17eTIePy2kXbjFdUganqOrfH_IE
Message-ID: <CAJuCfpGK63E-EtX4V7+Mgf9-KdBfvb27kzyZH6pYoYuzUQPnxQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] mm/vma: clean up __vma_enter/exit_locked()
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
> These functions are very confusing indeed. 'Entering' a lock could be
> interpreted as acquiring it, but this is not what these functions are
> interacting with.
>
> Equally they don't indicate at all what kind of lock we are 'entering' or
> 'exiting'. Finally they are misleading as we invoke these functions when =
we
> already hold a write lock to detach a VMA.
>
> These functions are explicitly simply 'entering' and 'exiting' a state in
> which we hold the EXCLUSIVE lock in order that we can either mark the VMA
> as being write-locked, or mark the VMA detached.
>
> Rename the functions accordingly, and also update
> __vma_end_exclude_readers() to return detached state with a __must_check
> directive, as it is simply clumsy to pass an output pointer here to
> detached state and inconsistent vs. __vma_start_exclude_readers().
>
> Finally, remove the unnecessary 'inline' directives.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mmap_lock.h |  4 +--
>  mm/mmap_lock.c            | 58 +++++++++++++++++++++++++++------------
>  2 files changed, 42 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 1887ca55ead7..d6df6aad3e24 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -211,8 +211,8 @@ static inline void vma_refcount_put(struct vm_area_st=
ruct *vma)
>         newcnt =3D __vma_refcount_put_return(vma);
>
>         /*
> -        * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> -        * their reference count, so wake it up if we were the last reade=
r
> +        * __vma_start_exclude_readers() may be sleeping waiting for read=
ers to
> +        * drop their reference count, so wake it up if we were the last =
reader
>          * blocking it from being acquired.
>          *
>          * We may be raced by other readers temporarily incrementing the
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1fabda07c922..72f15f606093 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -46,19 +46,44 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_PER_VMA_LOCK
>
> -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *d=
etached)
> +/*
> + * Now that all readers have been evicted, mark the VMA as being out of =
the
> + * 'exclude readers' state.
> + *
> + * Returns true if the VMA is now detached, otherwise false.
> + */
> +static bool __must_check __vma_end_exclude_readers(struct vm_area_struct=
 *vma)
>  {
> -       *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
> -                                         &vma->vm_refcnt);
> +       bool detached;
> +
> +       detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG=
,
> +                                        &vma->vm_refcnt);
>         __vma_lockdep_release_exclusive(vma);
> +       return detached;
>  }
>
>  /*
> - * __vma_enter_locked() returns 0 immediately if the vma is not
> - * attached, otherwise it waits for any current readers to finish and
> - * returns 1.  Returns -EINTR if a signal is received while waiting.
> + * Mark the VMA as being in a state of excluding readers, check to see i=
f any
> + * VMA read locks are indeed held, and if so wait for them to be release=
d.
> + *
> + * Note that this function pairs with vma_refcount_put() which will wake=
 up this
> + * thread when it detects that the last reader has released its lock.
> + *
> + * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in cases =
where we
> + * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fatal =
signal
> + * is permitted to kill it.
> + *
> + * The function will return 0 immediately if the VMA is detached, or wai=
t for
> + * readers and return 1 once they have all exited, leaving the VMA exclu=
sively
> + * locked.
> + *
> + * If the function returns 1, the caller is required to invoke
> + * __vma_end_exclude_readers() once the exclusive state is no longer req=
uired.
> + *
> + * If state is set to something other than TASK_UNINTERRUPTIBLE, the fun=
ction
> + * may also return -EINTR to indicate a fatal signal was received while =
waiting.
>   */
> -static inline int __vma_enter_locked(struct vm_area_struct *vma,
> +static int __vma_start_exclude_readers(struct vm_area_struct *vma,
>                 bool detaching, int state)
>  {
>         int err;
> @@ -85,13 +110,10 @@ static inline int __vma_enter_locked(struct vm_area_=
struct *vma,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
>                    state);
>         if (err) {
> -               bool detached;
> -
> -               __vma_exit_locked(vma, &detached);
> -               if (detached) {
> +               if (__vma_end_exclude_readers(vma)) {
>                         /*
>                          * The wait failed, but the last reader went away
> -                        * as well.  Tell the caller the VMA is detached.
> +                        * as well. Tell the caller the VMA is detached.
>                          */
>                         WARN_ON_ONCE(!detaching);
>                         err =3D 0;
> @@ -108,7 +130,7 @@ int __vma_start_write(struct vm_area_struct *vma, uns=
igned int mm_lock_seq,
>  {
>         int locked;
>
> -       locked =3D __vma_enter_locked(vma, false, state);
> +       locked =3D __vma_start_exclude_readers(vma, false, state);
>         if (locked < 0)
>                 return locked;
>
> @@ -121,10 +143,10 @@ int __vma_start_write(struct vm_area_struct *vma, u=
nsigned int mm_lock_seq,
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>
>         if (locked) {
> -               bool detached;
> +               bool detached =3D __vma_end_exclude_readers(vma);
>
> -               __vma_exit_locked(vma, &detached);
> -               WARN_ON_ONCE(detached); /* vma should remain attached */
> +               /* The VMA should remain attached. */
> +               WARN_ON_ONCE(detached);
>         }
>
>         return 0;
> @@ -148,14 +170,14 @@ void vma_mark_detached(struct vm_area_struct *vma)
>          */
>         if (unlikely(__vma_refcount_put_return(vma))) {
>                 /* Wait until vma is detached with no readers. */
> -               if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) =
{
> +               if (__vma_start_exclude_readers(vma, true, TASK_UNINTERRU=
PTIBLE)) {
>                         bool detached;
>
>                         /*
>                          * Once this is complete, no readers can incremen=
t the
>                          * reference count, and the VMA is marked detache=
d.
>                          */
> -                       __vma_exit_locked(vma, &detached);
> +                       detached =3D __vma_end_exclude_readers(vma);
>                         WARN_ON_ONCE(!detached);
>                 }
>         }
> --
> 2.52.0
>
