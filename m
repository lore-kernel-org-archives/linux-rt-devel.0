Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF2393DFD
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110302; cv=pass; b=Np3ZRimMks/eoKhFVCl1fsFXkbNkBFdavsNbESW1vWBGPvSIQ1kY08nnch9hJY3Q2nvw96Hn74+qVNGbFaBsVKC5wKHu3tNkE1oW4jLyhmuUi99nGX37tthbBMfxa/8Fz3crYvPP4xF6/vJC3JTZjNSFp3hkkT3lc8iPfIlpMZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110302; c=relaxed/simple;
	bh=LM/DU7Ci09rriB+leWWt1Axwq3WQs8uZfgSrb50s8JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRiMJS+rDJ1C0iiBpjF1yuY+SuFBwv7Lx3McoSvJFa0Tp6TmE4mc7RLrPCxNoL/MkGmcqASEl528f//O5V9H8LhtlHKcYcbLb4zPtI2Ic3v2TECmFK3wcTIFI1PB7/gI+t/knBma7hTim65q7kzJQemKiYDYkwa7piSfTAjkPMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqb7/cT9; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqb7/cT9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501511aa012so57731cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 11:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110278; cv=none;
        d=google.com; s=arc-20240605;
        b=IcKYNcFxyvB1vDlazVrVW3XkGuwu344XPXyF+4NxkZJvVwtbbNb+VzGfzPho+4w7+V
         sOHwgfbWBDyqtpXPsURsTUsUSvCqJ5s0WlcH28syQ22xwMhX0R/lSbyMGf1uHquVMC99
         BLzdz67bibtXmnfwVOVIqqSfQqBkeakNV2yl3xChm3i898pheCfRecztTdjxYh5UB/Lk
         u/9z77V0CUDvb3NMoN47LY+scC3bs2MPXd8rxaO0X2OL6HBh+AjnMxbaQXOjGya90X19
         y8Yf5FFuREGx4T7d1Gpg43BZ/Yh5/5J/52rKuYfOopw3vvmz/fihED27jUZdNOmGqQ02
         I5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBW80lcnBEWjjyGPBw5sRao2pYz5O7Wa287570viMLE=;
        fh=NlNYSamc+/pjmNU/XTEwS6KA9rNPzGMMPPZ4Ojzo2is=;
        b=hsBTDKgRa6rkQwaXkz1Go/tVjsSReZJ3azsRH5jalO5VYvwmRTf+AAhLl8Ics+OXwr
         NOVuxFGE3I5wSMO6AepGpPq2QhqVYv3/ozEVd94tnJnPYIqK1UCrqYMIY7cIotXg7nBr
         zYTrs3+MVyl80tpe4E1qTV879k29ir6mS+9wv8MdNi2q7wZmNvtbPwW2073MjoaveYkS
         eR2tw8YFJhDf9DKxjQITtYYCaIpoeokVr/M4fWGQXCy1wyimiUsEAlpg0VqbXtHDJE0S
         ePpCQa1LmNUrW62ner5HHwBCOmgQ4M3ZeWjoRizqO4YAzsboU+1jJsaBnwC8XXRqKu9e
         UNYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769110278; x=1769715078; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBW80lcnBEWjjyGPBw5sRao2pYz5O7Wa287570viMLE=;
        b=dqb7/cT9HM+S+47w2XVlo4qdntaAN9hHVh/tJiLVjFFrRjahRAn4769RtnkSYG/Xlm
         oCcOL4blyAxdNEBZQv7JIiNAHo0RtL6AWGay/T/OG4x9H1L2Q/u3xsNpGUyEAho2dO1F
         ltV+AngElBa+DUNpl6t/4KEkP0RQigMwwp0alJPxo5c/X8iqbKnaYHV6j7fNTPu7P/4e
         +uql4+nx/aLVrq1O3RIq53XakA5pEv9rN+Y+6Ho7BlWmWrHmE8Qr5QHhNIOACvKLq1iE
         HEDLNHjCFDP0folTQbCw5z/HiI/w7/rdakXosmm3lzidKRhr6Cro72cxgEWj45ZjfUNi
         KnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110278; x=1769715078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBW80lcnBEWjjyGPBw5sRao2pYz5O7Wa287570viMLE=;
        b=H1/0XJuQuUNb8fLJ+hfCjAD7BH01cd52DtTQqz3yuyrt80/J0Wp5Px5ydqkApcR3Xh
         atBfvAQ563mJPCWi5beyBJ8h8Xm6YCfz/jzVqSg1KXuyXT0UZjhmGTjKwB32Hs6FtvGd
         1hZyd999Bc0tRrOKjpB7qJXhqtbOW7r4vhjkCuLSqKyEDgmTK28Z1o0ZMlaimAjSVTcq
         Saw8DCoO7fVG0bIN7RrwozkTbseedyzhWtMuOA1olYUkgT2Qr2tjGezBX1lcqTQLlla1
         HUFD1EUqKnFJOUIhhEJHTyfc0qj9OobeuAn8YJ4/Ja/XHIpIh3gNNzddZQY3/bdvyqfo
         CzCw==
X-Forwarded-Encrypted: i=1; AJvYcCXA8rgiC9BYOnngAw0LMKfqXIQQfH43wT+p7WEISlzWahkG0QatfAlZFoV8iswZnIwKALg6GUmYkpPJQwNtyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCPpS5y+BFCL6iWUALWpuqWvMaLDbwWG/UPua7DwgZWMevrEpW
	J0NxZP+CDPSIQyrXDO4P1OzueKm4VpKoH8YZb6PrSJWnuVlPLLf979bT9b0xctNCzNhPo2fU3k9
	rGzBiVTyvVN9JsnhiJBKVYiV9mx8rowoA6/yM5tU5
X-Gm-Gg: AZuq6aLZzp9LGMrlyzm7MjTyQIQBotvsoa3vDN+16d8YQWc2i+sCVN+5RPn8fpXqWQg
	Weh3M9uT/ncvCsY3wXttlEIxErYWzuAxpxvgXa3uL1VPTf7JVbMGZArsuc8ZCuRWur774mMdPrD
	PGGOYcC0hODocrvvpABIbCTi/UgniXfn6aP+79Uh2dETaBIvWc31D+KyxeXa8+tjHZ5CbY3UkNb
	WpICZ0vlaB7ukB5ZLDU7Ja8HBor5eIXYsJt4xE+ALc2AaIjTakhttfz7ry8psaqizTezWZ5HnCX
	sOU/HhLvt9TN2cPrTquCKpni
X-Received: by 2002:ac8:7dcb:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-502f81098f6mr1305041cf.11.1769110277213; Thu, 22 Jan 2026
 11:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <c51d6396d78532d85a542da07ba783bc838b852f.1769086312.git.lorenzo.stoakes@oracle.com>
 <6f45d01a-7586-4d8a-8339-fdfbda4c971e@suse.cz>
In-Reply-To: <6f45d01a-7586-4d8a-8339-fdfbda4c971e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 11:31:05 -0800
X-Gm-Features: AZwV_Qjh5g2cATvu-aLTXs8yqxbYjNLzEtyyRnYIZ49mgFssb3IevuginMU801g
Message-ID: <CAJuCfpHhVOC5kzapSPtvUHGy3jMr8DyjPba7tkSv5zOWotvcQw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 03/10] mm/vma: rename is_vma_write_only(),
 separate out shared refcount put
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

On Thu, Jan 22, 2026 at 9:36=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/22/26 14:01, Lorenzo Stoakes wrote:
> > The is_vma_writer_only() function is misnamed - this isn't determining =
if
> > there is only a write lock, as it checks for the presence of the
> > VM_REFCNT_EXCLUDE_READERS_FLAG.
> >
> > Really, it is checking to see whether readers are excluded, with a
> > possibility of a false positive in the case of a detachment (there we
> > expect the vma->vm_refcnt to eventually be set to
> > VM_REFCNT_EXCLUDE_READERS_FLAG, whereas for an attached VMA we expect i=
t to
> > eventually be set to VM_REFCNT_EXCLUDE_READERS_FLAG + 1).
> >
> > Rename the function accordingly.
> >
> > Relatedly, we use a finnicky __refcount_dec_and_test() primitive direct=
ly
> > in vma_refcount_put(), using the old value to determine what the refere=
nce
> > count ought to be after the operation is complete (ignoring racing
> > reference count adjustments).

Sorry, by mistake I replied to an earlier version here:
https://lore.kernel.org/all/CAJuCfpF-tVr=3D=3DbCf-PXJFKPn99yRjfONeDnDtPvTkG=
Ufyuvtcw@mail.gmail.com/
Copying my comments here.

IIUC, __refcount_dec_and_test() can decrement the refcount by only 1
and the old value returned (oldcnt) will be the exact value that it
was before this decrement. Therefore oldcnt - 1 must reflect the
refcount value after the decrement. It's possible the refcount gets
manipulated after this operation but that does not make this operation
wrong. I don't quite understand why you think that's racy or finnicky.

> >
> > Wrap this into a __vma_refcount_put() function, which we can then utili=
se
> > in vma_mark_detached() and thus keep the refcount primitive usage
> > abstracted.
> >
> > Also adjust comments, removing duplicative comments covered elsewhere a=
nd
> > adding more to aid understanding.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Again very useful, thanks!
>
> > ---
> >  include/linux/mmap_lock.h | 62 +++++++++++++++++++++++++++++++--------
> >  mm/mmap_lock.c            | 18 +++++-------
> >  2 files changed, 57 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index a764439d0276..0b3614aadbb4 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -122,15 +122,27 @@ static inline void vma_lock_init(struct vm_area_s=
truct *vma, bool reset_refcnt)
> >       vma->vm_lock_seq =3D UINT_MAX;
> >  }
> >
> > -static inline bool is_vma_writer_only(int refcnt)
> > +/**
> > + * are_readers_excluded() - Determine whether @refcnt describes a VMA =
which has
> > + * excluded all VMA read locks.
> > + * @refcnt: The VMA reference count obtained from vm_area_struct->vm_r=
efcnt.
> > + *
> > + * We may be raced by other readers temporarily incrementing the refer=
ence
> > + * count, though the race window is very small, this might cause spuri=
ous
> > + * wakeups.
>
> I think this part about spurious wakeups belongs more to the usage of the
> function in vma_refcount_put()? Because there are no wakeups done here. S=
o
> it should be enough to explain how it can be false positive like in the
> paragraph below.
>
> > + *
> > + * In the case of a detached VMA, we may incorrectly indicate that rea=
ders are
> > + * excluded when one remains, because in that scenario we target a ref=
count of
> > + * VM_REFCNT_EXCLUDE_READERS_FLAG, rather than the attached target of
> > + * VM_REFCNT_EXCLUDE_READERS_FLAG + 1.
> > + *
> > + * However, the race window for that is very small so it is unlikely.
> > + *
> > + * Returns: true if readers are excluded, false otherwise.
> > + */
> > +static inline bool are_readers_excluded(int refcnt)
>
> I wonder if a include/linux/ header should have such a generically named
> function (I understand it's necessary for it to be here). Maybe prefix th=
e
> name and make the comment not a kerneldoc because it's going to be only t=
he
> vma locking implementation using it and not the vma locking end-users? (i=
.e.
> it's "intermediate").
>
> >  {
> >       /*
> > -      * With a writer and no readers, refcnt is VM_REFCNT_EXCLUDE_READ=
ERS_FLAG
> > -      * if the vma is detached and (VM_REFCNT_EXCLUDE_READERS_FLAG + 1=
) if it is
> > -      * attached. Waiting on a detached vma happens only in
> > -      * vma_mark_detached() and is a rare case, therefore most of the =
time
> > -      * there will be no unnecessary wakeup.
> > -      *
> >        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> >        * details of possible refcnt values.
> >        */
> > @@ -138,18 +150,42 @@ static inline bool is_vma_writer_only(int refcnt)
> >               refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
> >  }
> >
> > +static inline bool __vma_refcount_put(struct vm_area_struct *vma, int =
*refcnt)
>
> Basically change are_readers_excluded() like this, with __vma prefix?
>
> But this one could IMHO use use some comment (also not kerneldoc) saying
> what the return value and *refcnt indicate?
>
> > +{
> > +     int oldcnt;
> > +     bool detached;
> > +
> > +     detached =3D __refcount_dec_and_test(&vma->vm_refcnt, &oldcnt);
> > +     if (refcnt)
> > +             *refcnt =3D oldcnt - 1;
> > +     return detached;

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

> > +}
> > +
> > +/**
> > + * vma_refcount_put() - Drop reference count in VMA vm_refcnt field du=
e to a
> > + * read-lock being dropped.
> > + * @vma: The VMA whose reference count we wish to decrement.
> > + *
> > + * If we were the last reader, wake up threads waiting to obtain an ex=
clusive
> > + * lock.
> > + */
> >  static inline void vma_refcount_put(struct vm_area_struct *vma)
> >  {
> > -     /* Use a copy of vm_mm in case vma is freed after we drop vm_refc=
nt */
> > +     /* Use a copy of vm_mm in case vma is freed after we drop vm_refc=
nt. */
> >       struct mm_struct *mm =3D vma->vm_mm;
> > -     int oldcnt;
> > +     int refcnt;
> > +     bool detached;
> >
> >       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > -     if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> >
> > -             if (is_vma_writer_only(oldcnt - 1))
> > -                     rcuwait_wake_up(&mm->vma_writer_wait);
> > -     }
> > +     detached =3D __vma_refcount_put(vma, &refcnt);
> > +     /*
> > +      * __vma_enter_locked() may be sleeping waiting for readers to dr=
op
> > +      * their reference count, so wake it up if we were the last reade=
r
> > +      * blocking it from being acquired.
> > +      */
> > +     if (!detached && are_readers_excluded(refcnt))
> > +             rcuwait_wake_up(&mm->vma_writer_wait);
> >  }
> >
> >  /*
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 75dc098aea14..ebacb57e5f16 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -130,25 +130,23 @@ EXPORT_SYMBOL_GPL(__vma_start_write);
> >
> >  void vma_mark_detached(struct vm_area_struct *vma)
> >  {
> > +     bool detached;
> > +
> >       vma_assert_write_locked(vma);
> >       vma_assert_attached(vma);
> >
> >       /*
> > -      * We are the only writer, so no need to use vma_refcount_put().
> > -      * The condition below is unlikely because the vma has been alrea=
dy
> > -      * write-locked and readers can increment vm_refcnt only temporar=
ily

I think the above part of the comment is still important and should be
kept intact.

> > -      * before they check vm_lock_seq, realize the vma is locked and d=
rop
> > -      * back the vm_refcnt. That is a narrow window for observing a ra=
ised
> > -      * vm_refcnt.
> > -      *
> >        * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> >        * details of possible refcnt values.
> >        */
> > -     if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> > +     detached =3D __vma_refcount_put(vma, NULL);
> > +     if (unlikely(!detached)) {
> >               /* Wait until vma is detached with no readers. */
> >               if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) =
{
> > -                     bool detached;
> > -
> > +                     /*
> > +                      * Once this is complete, no readers can incremen=
t the
> > +                      * reference count, and the VMA is marked detache=
d.
> > +                      */
> >                       __vma_exit_locked(vma, &detached);
> >                       WARN_ON_ONCE(!detached);
> >               }
> > --
> > 2.52.0
>
