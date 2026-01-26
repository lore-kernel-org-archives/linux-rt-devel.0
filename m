Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78820242D6C
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455303; cv=pass; b=rOsQ5uTp5ybmOQBQHBIffYgxxAAMHVfVOXjRsgr+/+nNtk04rurTH2YadObA6OGooc9HnYkiE39MbppMXLIzQySEIz/X6b1K6dynD6dwE+54sTi6QyW9vP2hX42NWrnfojRG4zuUMC9THF1NPFrV9ybjzdxnTB2uIZphCfm9NFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455303; c=relaxed/simple;
	bh=5qMEyVigyJ1vr+IAKg6l9dpb22AqNd824CdNbMvUmAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuTgrAXsxO0yD5d/YmOl+JgoTNdtjywxETIRa4EJNQRdw9vq/AB/EZPME3oV9wCS2u88D6z363Hdt1yiGIZPMrh2+e0oOJXh5LD5JVeDPZuMsDDTcj5/qIsq3Hx2xP6AHa+1R0E6yiuWxDloRp8xermnGGi6Ci6vu8Pi0aT1LA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0rCuZxe; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0rCuZxe"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014b5d8551so71721cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 11:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769455300; cv=none;
        d=google.com; s=arc-20240605;
        b=NYoUlUr7tkMVayOJHZKeE2LBLnZGL3L2vpsdH1CKQxuI8IWs8Tk35jQWEsSI+qjO5b
         RL/MivkOscgdt8sOHd2yZ1TiMlE2C37m2FcG+3eyJKcNQD6aV4K4GccPIIaTpUwnFBYp
         iT/vgaBO52bDHHmoEG1V7HPdk9iluFXlfnK7VLZYmcusvHgAEi0Jo465SSTJYU0cHFj8
         8Od+U1fk2k3q/s7BBtty4ArVKJ6dAopk9v0LXRumRjRgSBF/MTrOELocMISDTvOCmKQz
         1lOQQKcH3tYVXKhjLzwHFifepC2SL+7jQ4+Ylu+hajD9U6iU5+ZL8c2tNrLphV89eLYu
         a63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYW3g8zubsKps0K33/sRTflluIAFrC4jqoC29wkQbGs=;
        fh=eFxFVC2vQ/OhiIYPU6+wUI04uwntIDjJz0itNTsiLyY=;
        b=fOo+iB1r81CpD0f89G4P93DkkdbG1hA5VYLTzfNCMzyv1ZvAAMqYap2H2nsqCBpgK3
         a0UCyL7VyuAMdVqrikSyEixtexurCRS3J5RVcPdJRIJz96GmZQTEL0Xw6kTb/jIYpFOS
         nzHVnHZjXadNBWkOs+1R81379h0oTdEJKLsWERIVUPToJruGxPmBjDblRzvmZSvOFGFl
         QVAVe9i6OmWtFJr+m/YTGN4ryJKO3514n9Ya0TYX+Sh8EcscSmj2A64FFbiU4Xicblkk
         w8yXGwFi/qxhyfc5Z4liGQEoi6QsyH3PCHDDBqV42TVQXfJMNeM+wudUDaBHSVVazFy3
         sjqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769455300; x=1770060100; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYW3g8zubsKps0K33/sRTflluIAFrC4jqoC29wkQbGs=;
        b=T0rCuZxe5viEpFTuaNJdGuoZIhwAvPgDYP1PWYJ7bMnXfWUHx+zeWY6cDUtQcG/kYf
         r4aQpO3XbA5RRo0UnY6yTlaoyM0LRpItETIANLjO4ZTLXRyeSVFSZ1f0+ZpB517DtlV/
         nJiYZFSK429dtVuwiugqLxhAZU9Ja4U5iHi45yblrGpOLdcxceMnBm4ozR1pOwM2otAu
         +nsll7OMFKAbWwAvx/jQ7GAVQDhwafk2SPzRzEm3wVgy7CoWex03StHW97eNd0whujV3
         CCamBBh7Hh1yMAaqGq74WNl8xAcIbWindoT1pNDKmrN68GNlrdlZvxB18Yp1nuqBbjBJ
         YAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769455300; x=1770060100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYW3g8zubsKps0K33/sRTflluIAFrC4jqoC29wkQbGs=;
        b=b93VbRJMI6gM5+0pPusaDcxjG/BGAy7iGbswAq+PcbbmjrwVstp4UavTEc0Vl8yaw9
         eFPKLtIj0SuqIim5Lddj/aEAvqyNAlm55266m3h43ulwVfP82tr1LeZfwuZZLXX848kU
         Xm9lepSbsTXXzf3THaxPxjtgeWDiDk5wPsFhMDZqTewQ62Px3A4KmSqGzHqVeWA45HgM
         nZ/05gi1rpQzSo5zGDJ58d00+tREk+vPCiyTlaoGDs9r3+PxUtcbz+B256MBRnXjVv66
         XjM8Ul7TynB0X7sSPgN4rvxwBNBBRc+u9+eM9rjp8FWuAMeyh5KO6LaGFP/CzabBT3Bs
         oclg==
X-Forwarded-Encrypted: i=1; AJvYcCU9cQ5uQDG4vXJr+ppBCx1xYRhGBA8MEiaQw68cCOqfbWDbQehXkrauTW5swej6qcnL+mKhAsrCBTF4P5Vo7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxsPPk2rGasBgKMZ4MFX30OdR6SXOUCBK6E67PxcWS6P/GbYTt
	PMwNODoyYQmWnaSplGIictkxHVoSER9cvXdtwPUDQFKMXPdw2lVyAjwQgSX4QOvkbI9GqWJTlbt
	RuOqImHKc/QS2+uVotlRVK0GAlrEtNbXIR1InnNfd
X-Gm-Gg: AZuq6aK7UQH7LA6wBcPZOtgs5KrFkREWpYvhwq84u/1c6fNC6v6vxfh5o6ecwa74Ku+
	/k28ze5ymSEnjWr7feBBvW17NJXCR3Zomg3gjtHSoSdm6MeckjlfeMB2V5SA0YeUeGXFFQfdWLT
	QdOXJT1oqf3H89vv5H7uGLEMFEDJjZCQdfcV50m+jD8yIpg/uK7k9+JSN9f2WVB2ppUBpUhG6jR
	fgnce1NX8HAB8hjaoUArnUUmidcg5Ae5JZp0tmEYUHiC519VW0AzE/IcC8F7PIkG54HUw==
X-Received: by 2002:ac8:574b:0:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-5031428f27emr2159301cf.6.1769455299991; Mon, 26 Jan 2026
 11:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <ef6c415c2d2c03f529dca124ccaed66bc2f60edc.1769198904.git.lorenzo.stoakes@oracle.com>
 <47eafa10-6d13-4324-830a-2e7cf4e67f2b@suse.cz> <6444753e-1df7-4732-912a-0ea441f76cb1@lucifer.local>
In-Reply-To: <6444753e-1df7-4732-912a-0ea441f76cb1@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Jan 2026 11:21:29 -0800
X-Gm-Features: AZwV_QgPNzfNfXGAlKz4oU77bmBtnXD6k2LfcRE7XAUitpkpeYH7g04K8qEwn1M
Message-ID: <CAJuCfpEBHsuGJFAGyXdASpaV_FY0_RBShKZM3QA_9z7ZvAtu6g@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mm/vma: improve and document __is_vma_write_locked()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 8:29=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Jan 26, 2026 at 12:30:04PM +0100, Vlastimil Babka wrote:
> > On 1/23/26 21:12, Lorenzo Stoakes wrote:
> > > We don't actually need to return an output parameter providing mm seq=
uence
> > > number, rather we can separate that out into another function -
> > > __vma_raw_mm_seqnum() - and have any callers which need to obtain tha=
t
> > > invoke that instead.
> > >
> > > The access to the raw sequence number requires that we hold the exclu=
sive
> > > mmap lock such that we know we can't race vma_end_write_all(), so mov=
e the
> > > assert to __vma_raw_mm_seqnum() to make this requirement clear.
> > >
> > > Also while we're here, convert all of the VM_BUG_ON_VMA()'s to
> > > VM_WARN_ON_ONCE_VMA()'s in line with the convention that we do not in=
voke
> > > oopses when we can avoid it.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Sorry but I have one more comment below.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>
> >
> > Few nits:
> >
> > > ---
> > >  include/linux/mmap_lock.h | 44 ++++++++++++++++++++++---------------=
--
> > >  1 file changed, 25 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index 678f90080fa6..23bde4bd5a85 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -258,17 +258,30 @@ static inline void vma_end_read(struct vm_area_=
struct *vma)
> > >     vma_refcount_put(vma);
> > >  }
> > >
> > > -/* WARNING! Can only be used if mmap_lock is expected to be write-lo=
cked */
> > > -static inline bool __is_vma_write_locked(struct vm_area_struct *vma,=
 unsigned int *mm_lock_seq)
> > > +static inline unsigned int __vma_raw_mm_seqnum(struct vm_area_struct=
 *vma)

This function returns the mm->mm_lock_seq.sequence attribute of mm, so
no real commection to VMA. IMO it's better to rename it into
__raw_mm_lock_seqnum(const struct mm_struct *mm) and have the callers
pass vma->vm_mm.

> > >  {
> > > +   const struct mm_struct *mm =3D vma->vm_mm;
> > > +
> > > +   /* We must hold an exclusive write lock for this access to be val=
id. */
> > >     mmap_assert_write_locked(vma->vm_mm);

If for some reason you need to keep this function VMA-centric, then in
the above line please s/vma->vm_mm/mm

> > > +   return mm->mm_lock_seq.sequence;
> > > +}
> > >
> > > +/*
> > > + * Determine whether a VMA is write-locked. Must be invoked ONLY if =
the mmap
> > > + * write lock is held.
> > > + *
> > > + * Returns true if write-locked, otherwise false.
> > > + *
> > > + * Note that mm_lock_seq is updated only if the VMA is NOT write-loc=
ked.
> >
> > This line is no longer applicable.
>
> Is there for nostalgia's sake! :P
>
> OK maybe not...
>
> >
> > > + */
> > > +static inline bool __is_vma_write_locked(struct vm_area_struct *vma)
> > > +{
> > >     /*
> > >      * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
> > >      * mm->mm_lock_seq can't be concurrently modified.
> > >      */
> > > -   *mm_lock_seq =3D vma->vm_mm->mm_lock_seq.sequence;
> > > -   return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
> > > +   return vma->vm_lock_seq =3D=3D __vma_raw_mm_seqnum(vma);
> > >  }
> > >
> > >  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lo=
ck_seq,
> > > @@ -281,12 +294,10 @@ int __vma_start_write(struct vm_area_struct *vm=
a, unsigned int mm_lock_seq,
> > >   */
> > >  static inline void vma_start_write(struct vm_area_struct *vma)
> > >  {
> > > -   unsigned int mm_lock_seq;
> > > -
> > > -   if (__is_vma_write_locked(vma, &mm_lock_seq))
> > > +   if (__is_vma_write_locked(vma))
> > >             return;
> > >
> > > -   __vma_start_write(vma, mm_lock_seq, TASK_UNINTERRUPTIBLE);
> > > +   __vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_UNINTERRUPT=
IBLE);
> >
> > At this point I think __vma_start_write() could just perform
> > __vma_raw_mm_seqnum() itself and we can remove the param.
> > It could possibly make the inline code smaller.
> >
>
> Good idea!
>
> Will send fix-patch for both.
>
> Thanks, Lorenzo
