Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673239CB46
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102906; cv=pass; b=jLASPOoko+7XihKIGubEyIrGK1IV5jScaxh/ZenWJQWwJR7WeXal7LeA0F7USf91lWGXzUWy39O06EhyRW/grYwIp2ROE3k2/tdkneuA3IuM6e08c9bVpgg4hA0yxCiMIf4VEruzC0AY0FmM9Pz6htOHcmSzqs9DEdLuOSAvBns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102906; c=relaxed/simple;
	bh=+ksA8N8k2n5D3/kzgahd6VDNKfGPT8sA40xU8oXqSPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRPSz1g08z1nIGjUToBqunGqXSgvI+ilr5MM7/KXG034ZHhjluqNfYkvG0mopSu7fRXf2fIKQnEaizGtw3mP+jXmkjs25Rde9HKyAuKHlQBrJkzW4sbnJT1vuUx7VitSq5vU9eYheIkYB0ISa5M2rPJL68VlCvTF5H/Cu11JNCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIIJ3cgS; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIIJ3cgS"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014b5d8551so543441cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 09:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769102897; cv=none;
        d=google.com; s=arc-20240605;
        b=M1DUBTk/k0P2i5j8cD1vEuY6lJQ3cgzu7vUFWYQbJ/9HR5cuaC6TOJ70tawiI67rXu
         hkTW+g7J6a7P7Q3+95swGyj1orLDFPMns3L8fTS3q2AhPptdrpgTGmfiaMgazpiZ4/+d
         TVPiI/SfXG+Y/Wopi6BC1vw2rQxGdMJcmmE1VhFgq8wxwVGkFHcwy1Qe3/23isrUyuYC
         z+6SfaEKHfxvPHj9ojSRc9QhJQvqJqC+vgjW//wCUrXxL/f6CgSaGmu9xGn+yyR6BRCY
         QtsloXRkGfmdSdrEl2i1Hb+fK0WsJIVoYiqPkzv6ICkEokvLvqcUrYExr2qKZJwfHLz6
         M3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vKR+9mNOqKRizGQmFeK0caxIbjw2qX9Nz0/t9kP4530=;
        fh=fpmJcjlCMd0hDDXmvs67YTDXvJKeUsx22nub7DqNAUE=;
        b=a5Ge40a9N0wfbfg69L83w1kyss3oVF8MFkwyozVC5MkQ+VoQHCgqx8qSK2+ZftKlwL
         bBml0PX4COi7XymdT7ysembz96WzXaIXEVlt/HklZIKLLGCgvXf0Po6CR0xCjoP2LOSy
         A6/X/CBb1MNz2kAIfVrq5g9o3RDoVCEsJKVTtczgXg4+zbB2iTD5bSB3VnfnTDDSXVPC
         nx55zJwWzpOopY8E8vtF9n/JWi07PXyZ+SuK0eB5s9LM/y0TY0MqlLsRkdYVi2WAhxuo
         qIhqHIDLoPp46VRAvx8ImgGxRdxZBq91/0NkYq9XtHawm/F6Lnyx0dkSsGqeSlikEUvD
         1BHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769102897; x=1769707697; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKR+9mNOqKRizGQmFeK0caxIbjw2qX9Nz0/t9kP4530=;
        b=aIIJ3cgSNRdkDvZX6Ffj3bADp8FMGh4h3icFayuwhTHAif9DDG08nSSEi3B+wiyrl5
         EPDd99JDiNhs4QbyzyNgnrv8SAyvOICXVT1Wc3I0RRTD9d6D9bIxCqKfcCct7aFS1Sw1
         OZCCqIuw0LMCFPPfAhKzyLRDtMwW/ey9IVoqkGJNvLw2lxYgi5vWHsuccqTTZtiS+5oS
         Gjqn6IGQVcetPfdFLCgOkIZSqyQ4DQNuSpkfgx47MaKwAaCCM0zkmsKKyNzBlrWfkLGL
         o7YHZY26DSaomJF2JsxFs8PiaKbz7UZU2ZAksIT/c2/9DQ2uBtbql1zzBkDAV0p63lS9
         omsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102897; x=1769707697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKR+9mNOqKRizGQmFeK0caxIbjw2qX9Nz0/t9kP4530=;
        b=D4BGJ3K4Cs7ncPDHupP19lD0dVX2YHC2Gwx+kmiWaRrWGbeObMLJ1grVx7OLZr4kH0
         Hzw2Bw0NuzaPUAYieiuDE+NGC8mSafpRvBaF2fBrr0wQpwwMMJ42K2ImdIsTSEfAv62P
         2XGuCpcZGsSJUFweeqKBkUr2Sk0scLhak4TCN5cko59or3uY94fltNJTpZWhXMF3QXN6
         HgvgC+Sdj4+dEwsRCZMEMdnbg5857N1teUlCpdm4XeFNfxZLJltZm80KlN76DGefiGf+
         2dW7ULJEvKkhJYfAEYodkKqQjlIE8KJZnylXkIUi8MgwG4xtq60qq1kJJKgCJKr9TITp
         3eZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxlktucw5lTEE0yZwECmFE7q6O4arl6Sw7k507/Gj/qI0IfK+FyFJqpvjg/qDIcxmpvKzlgnAYLlu62O/54g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4v46uwEwNUvJHPQ+S3FBE0cRGy1JxQBl0Z+qXlShq1WktnqDm
	LSfo8TplGo7GDW5MXSoS+OqkFUA3SM8eJpKayCOHQvDcRP21lUV704hs7IcKvfBvT5osGNaCNsm
	gK4fOIHtGcRTCSfrQ5//NdYeLvuwjaHr5XmATXlCc
X-Gm-Gg: AZuq6aKyeTHcEwco3EubeUhv3Zg3jPxZsWElp9iwKiE0zRzrrOJkUWZXDmdSMcR6QCh
	CSrGyTtk+7ZMy83a5S7nflax/F6tA3g3MipZYGJa5PWL2Jp+/MJkrxdC8d9oHbYaJ+eCqNMXkrU
	/7xzu7ynyoDJRlSMyeyVjdD/yeGq5d5guaq4EJjbEj7nj+M15lyAGoXQXFRnV9M779X+6uZ52Q6
	Q0KltcaEqVd6VNG1jEz/2xNtP4AqM3Iy2XqBE8ecDCvARMcUmZ1F36cGcZnUjeyKFveCWFpQ0hy
	4TYeU75ZDWPVyVCb2QOgA1JJ
X-Received: by 2002:a05:622a:5f05:b0:502:f58b:49bb with SMTP id
 d75a77b69052e-502f58b4cc6mr3220861cf.9.1769102896508; Thu, 22 Jan 2026
 09:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <a28f56dbe5057385b07498684dfb105918bf3644.1769086312.git.lorenzo.stoakes@oracle.com>
 <7876e97c-9afb-418a-8ef7-5f4f306b7eea@suse.cz>
In-Reply-To: <7876e97c-9afb-418a-8ef7-5f4f306b7eea@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 09:28:05 -0800
X-Gm-Features: AZwV_Qj5mha76ke8ifuGRZO6bD7iXP8oHrXlIUbFTB1-LzCBB2mAqlQ9bOo7PfQ
Message-ID: <CAJuCfpEyxqSfiK0M4VfKmZnp2OGYm-Le882aFNhPSef1fSCT0w@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 02/10] mm/vma: document possible vma->vm_refcnt
 values and reference comment
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

On Thu, Jan 22, 2026 at 8:48=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/22/26 14:01, Lorenzo Stoakes wrote:
> > The possible vma->vm_refcnt values are confusing and vague, explain in
> > detail what these can be in a comment describing the vma->vm_refcnt fie=
ld
> > and reference this comment in various places that read/write this field=
.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks, very useful. Forgive my nitpicks :) It's because it's tricky so b=
est
> try to be as precise as possible, I believe.

Another thanks from me.

>
> > ---
> >  include/linux/mm_types.h  | 39 +++++++++++++++++++++++++++++++++++++--
> >  include/linux/mmap_lock.h |  7 +++++++
> >  mm/mmap_lock.c            |  6 ++++++
> >  3 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 94de392ed3c5..e5ee66f84d9a 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -758,7 +758,8 @@ static inline struct anon_vma_name *anon_vma_name_a=
lloc(const char *name)
> >   * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indicia=
te to
> >   * vma_start_read() that the reference count should be left alone.
> >   *
> > - * Once the operation is complete, this value is subtracted from vma->=
vm_refcnt.
> > + * See the comment describing vm_refcnt in vm_area_struct for details =
as to
> > + * which values the VMA reference count can be.
> >   */
> >  #define VM_REFCNT_EXCLUDE_READERS_BIT        (30)
> >  #define VM_REFCNT_EXCLUDE_READERS_FLAG       (1U << VM_REFCNT_EXCLUDE_=
READERS_BIT)
> > @@ -989,7 +990,41 @@ struct vm_area_struct {
> >       struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
> >  #endif
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -     /* Unstable RCU readers are allowed to read this. */
> > +     /*
> > +      * Used to keep track of the number of references taken by VMA re=
ad or
> > +      * write locks. May have the VM_REFCNT_EXCLUDE_READERS_FLAG set
>
> I wonder about the "or write locks" part. The process of acquiring it use=
s
> VM_REFCNT_EXCLUDE_READERS_FLAG but then the writer doesn't hold a 1
> refcount? (the sentence could be read it way IMHO) It's vma being attache=
d
> that does, AFAIK?

Yes, since there can be only one write-locker it only has to set
VM_REFCNT_EXCLUDE_READERS_FLAG bit to announce its presence, without
incrementing the refcount.

>
> > +      * indicating that a thread has entered __vma_enter_locked() and =
is
> > +      * waiting on any outstanding read locks to exit.
> > +      *
> > +      * This value can be equal to:
> > +      *
> > +      * 0 - Detached.
>
> Is it worth saying that readers can't increment the refcount?

Yes, you mention that for VM_REFCNT_EXCLUDE_READERS_FLAG value. The
same IMPORTANT notice applies here.

>
> > +      * 1 - Unlocked or write-locked.
>
> "Attached and either unlocked or write-locked." ?

Agree. That's more specific.
Should we also mention here that unlocked vs write-locked distinction
is determined using the vm_lock_seq member?

>
> (see how "write-locked" isn't reflected, I argued above)
>
> > +      *
> > +      * >1, < VM_REFCNT_EXCLUDE_READERS_FLAG - Read-locked or (unlikel=
y)
> > +      * write-locked with other threads having temporarily incremented=
 the
> > +      * reference count prior to determining it is write-locked and
> > +      * decrementing it again.
>
> Ack.
>
> > +      * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
> > +      * __vma_exit_locked() completion which will decrement the refere=
nce
> > +      * count to zero. IMPORTANT - at this stage no further readers ca=
n
> > +      * increment the reference count. It can only be reduced.
> > +      *
> > +      * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - Either an attached VMA pe=
nding
> > +      * __vma_exit_locked() completion which will decrement the refere=
nce
> > +      * count to one, OR a detached VMA waiting on a single spurious r=
eader
> > +      * to decrement reference count. IMPORTANT - as above, no further
> > +      * readers can increment the reference count.
> > +      *
> > +      * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - VMA is waiting on reade=
rs,
>
> "VMA is waiting" sounds weird? a thread might be, but VMA itself?
> (similarly in the previous paragraph)

Maybe "VMA in the process of being write-locked or detached, which got
blocked due to the spurious readers that temporarily raised the
refcount"?

>
> > +      * whether it is attempting to acquire a write lock or attempting=
 to
> > +      * detach. IMPORTANT - as above, no ruther readers can increment =
the
> > +      * reference count.
> > +      *
> > +      * NOTE: Unstable RCU readers are allowed to read this.
> > +      */
> >       refcount_t vm_refcnt ____cacheline_aligned_in_smp;
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >       struct lockdep_map vmlock_dep_map;
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 5acbd4ba1b52..a764439d0276 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -130,6 +130,9 @@ static inline bool is_vma_writer_only(int refcnt)
> >        * attached. Waiting on a detached vma happens only in
> >        * vma_mark_detached() and is a rare case, therefore most of the =
time
> >        * there will be no unnecessary wakeup.
> > +      *
> > +      * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> > +      * details of possible refcnt values.
> >        */
> >       return (refcnt & VM_REFCNT_EXCLUDE_READERS_FLAG) &&
> >               refcnt <=3D VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
> > @@ -249,6 +252,10 @@ static inline void vma_assert_locked(struct vm_are=
a_struct *vma)
> >  {
> >       unsigned int mm_lock_seq;
> >
> > +     /*
> > +      * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> > +      * details of possible refcnt values.
> > +      */
> >       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <=3D 1 &&
> >                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> >  }
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 1d23b48552e9..75dc098aea14 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -65,6 +65,9 @@ static inline int __vma_enter_locked(struct vm_area_s=
truct *vma,
> >       /*
> >        * If vma is detached then only vma_mark_attached() can raise the
> >        * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attac=
hed().
> > +      *
> > +      * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> > +      * details of possible refcnt values.
> >        */
> >       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->=
vm_refcnt))
> >               return 0;
> > @@ -137,6 +140,9 @@ void vma_mark_detached(struct vm_area_struct *vma)
> >        * before they check vm_lock_seq, realize the vma is locked and d=
rop
> >        * back the vm_refcnt. That is a narrow window for observing a ra=
ised
> >        * vm_refcnt.
> > +      *
> > +      * See the comment describing the vm_area_struct->vm_refcnt field=
 for
> > +      * details of possible refcnt values.
> >        */
> >       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> >               /* Wait until vma is detached with no readers. */
> > --
> > 2.52.0
>
