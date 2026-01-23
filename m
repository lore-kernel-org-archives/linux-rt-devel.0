Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993DB1E9919
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196880; cv=pass; b=LZxQspArAGKsfO3FEH9Z3eRPU5GsxOWMzg9hzo2WMbUCjEqGuovZgUv1f0D2PnHaWMpi0f9td9z/5WojMcUUW3gNxXj9sl3vsotj/RwbGtLMbv+ObGZhTTTmpVOE0U+pdKd60NxhS2Ryksk4wRb2KZFVH8CmY3BB+52/qRgVeMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196880; c=relaxed/simple;
	bh=5BCNUbX9PVJvO4Rtei7cOuBArkpxMIaEz4n37toqksU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRnfuM0r/sk/isnzNLkSLgxS8ayladQYJcWvO3Q0m/qotqBwWlw55TBAG3aMOoiRyTs/MblJ9Qp0RfO8FzE5TfhUjq7cnP1i+nV4jnEnzKxsRkVAlNbrzOKUOrnRsMjwu4cYd/wkmNcZmhNSUM2jdiZD/ESxU6OVBnSuaRhDToE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISra1Ga7; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISra1Ga7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-501511aa012so66051cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769196877; cv=none;
        d=google.com; s=arc-20240605;
        b=kfu5Qo0Oms9wSzTD01xpxFTomm6C0kza3XtF747rqBrFpyj5pH4UPEvlAHRMO0b+9P
         bdtx0Ts0fNAdRLXlOH/FtgVPckfoxnb6PHxoELrVs7e4F+ZemX84CwwK7SgYSh9OC5sy
         EG/yYYK8CKtlS4MpEWacDVwMX0+JJSPdZMQW4Wb/1ruxqhU21OarU53W5kHmo/8lSFGL
         V0KBd726ZGr2jhPnyio5RpK6BHSMdq73bM4BieylxeNo/41dJfOdbIKFRR46tElB/Dr/
         XUmC87b96V12BNxPzTnNpffk+Z9mx8RRDcuSAJIu71a5LlVNW6AsUcC0mz5XMJsUbvql
         QE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4VBbAU8vd/2KklhA5UGdiDmofO3byk15wh5Af9y9vUQ=;
        fh=6x3rDsL4aBcSKBwXDMDFPvjOTHkTwcpVmHrIiKMyM1c=;
        b=ko55a4aDyvZpFyFaHH5MKy0xfgb9Yz+dqNnAm8qHTifYUohUV3eCaxmmlFqh3cSxqB
         J0jEoTvnoSAu5Xh2L25trVcbpKk97qgV87e0D/J9EhzS/ibY0HZ9IIUzQgfjdutxy/t+
         W98J57XqdpUXisKbOp0+OCeQJliTSX2fPNri/66mpKaza0SJsQXDjxGqg8x6sGDti4+/
         bE/40rfCx0kQL2v7RiK8DMSqwqb5STAUKl1Tk0/AqrhXAyqb+8g9qcy06TvXFFKuX/xT
         Dl7WPcSzHZsd/iBXT4T/oKrbqTAZU/uatd2Ykcv9O5YRV5HXqTwvJx/R0PnmWdT65Otx
         9TsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769196877; x=1769801677; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VBbAU8vd/2KklhA5UGdiDmofO3byk15wh5Af9y9vUQ=;
        b=ISra1Ga7YnWCC4/8n5S37uUncKH6HbJ7qtqldfOlwR956AthVYSXmHU9O5jKKbtBFi
         kfVPK9DPRS5TIHr2hoDua0GsMF75sWJWGlYs+oSLITzYPHxC7/hi4zmqRrnb0C3hb/Vz
         dOYYWNv3EtblV6ockGLew7i6djZxkrrQ3cWmiGZFw6XkPmURLcHEin1Be0WXNzW/8y5a
         X+sTTQhGMei/EJI61rrJiBkHD1hLYdVoYETI34ul47HUFqOy/nqce9dsJ0olfumjlC1s
         GH4d6l9az33HdnhAUezZeVlXTyWNzzLNYfzz+W+6AQimKIWoESEobyxuJqqB4Y1qVWh8
         XaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196877; x=1769801677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VBbAU8vd/2KklhA5UGdiDmofO3byk15wh5Af9y9vUQ=;
        b=o0TRKk93saK3uy7eFjqzpYxQLqNMe1IiFpwTBFWw5yJIUdSDH0O20uMqgava8Rts77
         6PQs8sCwi0Xv/n7sqYSkAPjDlqz4dZrZSikcHEQQyNCYIN98swY+szDqhe8vxHu3y+4C
         RJTxaupjzy6VrmK5+XvTrNEDyoCrIRXMlkf3WRMCpJ7SbcrXkL0B5aYn2sYhbByCdIV6
         hOOIrunju0CX/El3DPaOFX+oggQjBAh7mqLgsIVZrJKnTgP6h4ITCBkQJlvL8r7rI3oz
         DqdBeM/JCIwjtwek/3Pcu0L1pYj+CSVWkK9zQazRIBlt8JJemtn+V0E21+mYuXGJtTHd
         Ti4A==
X-Forwarded-Encrypted: i=1; AJvYcCXq37Sg/VzQB4BJVSTrk47j2SETON8GdORdIdghvP56UimDGXk90NdKmG7jV/M1BecJuqFtRoz2NzvAGe6vow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsQVmpgAkaiRDietZe6JyH1mezSKDZrZau07U80oPzUPbfeKto
	drMuHlg0mdNcNCsKNixzwTLlOgLJb4GTbv22zCvWpU66Kt56c3EYcAjNxCQvxgR0IDmuJBf7E/+
	ceNWXUhTzRVrcrpaYHSaXYhd0wYiViAtQCz+I9tU6
X-Gm-Gg: AZuq6aLj4W/6rFLJW4M2X7UR+SywonpQMaor7v5DccSxlL1KqiBZGkez6I7+uHsjo6f
	cydUx04dZqyEfYZH1udKRC/HI7DMF+hKqCE1vzhv8NGm49DSxdl/Rv44LwB4RvRf+hwTRgXSJAO
	SAsB8Covz0+iUXcamglV87ooHoymtb7J2QYVF3+BSxRDt629KKt25ttgTSDm6POcFHf82fs9N36
	sKp96LUuLxXBU7iH02UfWRqp5++nUn9t3RYCfsirr9g66FxC5eL5azykbrIQvVr2fPDhQ==
X-Received: by 2002:a05:622a:19a7:b0:502:f07e:854c with SMTP id
 d75a77b69052e-5030513a13dmr1303931cf.6.1769196876925; Fri, 23 Jan 2026
 11:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEULwMTxAzxUdzfpHe2=+umXL6HFMvydkqW=tP8mB2ewg@mail.gmail.com> <c7c8158d-e360-4a29-9e48-f2b45b9ca147@lucifer.local>
In-Reply-To: <c7c8158d-e360-4a29-9e48-f2b45b9ca147@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Jan 2026 11:34:25 -0800
X-Gm-Features: AZwV_QglINHieQVVU9Ln3erH7fB3eaWb2v8z1U93ye9e7yoFwpUXra2dZpBIa5Q
Message-ID: <CAJuCfpFbsAHr76ZfUEaRLzdxQMDjPEP+bsLNC35X9t53G_uqAg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
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

On Fri, Jan 23, 2026 at 9:59=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 22, 2026 at 01:41:39PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 22, 2026 at 5:03=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > It is confusing to have __vma_enter_exclusive_locked() return 0, 1 or=
 an
> > > error (but only when waiting for readers in TASK_KILLABLE state), and
> > > having the return value be stored in a stack variable called 'locked'=
 is
> > > further confusion.
> > >
> > > More generally, we are doing a lock of rather finnicky things during =
the
> > > acquisition of a state in which readers are excluded and moving out o=
f this
> > > state, including tracking whether we are detached or not or whether a=
n
> > > error occurred.
> > >
> > > We are implementing logic in __vma_enter_exclusive_locked() that
> > > effectively acts as if 'if one caller calls us do X, if another then =
do Y',
> > > which is very confusing from a control flow perspective.
> > >
> > > Introducing the shared helper object state helps us avoid this, as we=
 can
> > > now handle the 'an error arose but we're detached' condition correctl=
y in
> > > both callers - a warning if not detaching, and treating the situation=
 as if
> > > no error arose in the case of a VMA detaching.
> > >
> > > This also acts to help document what's going on and allows us to add =
some
> > > more logical debug asserts.
> > >
> > > Also update vma_mark_detached() to add a guard clause for the likely
> > > 'already detached' state (given we hold the mmap write lock), and add=
 a
> > > comment about ephemeral VMA read lock reference count increments to c=
larify
> > > why we are entering/exiting an exclusive locked state here.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap_lock.c | 144 +++++++++++++++++++++++++++++++----------------=
--
> > >  1 file changed, 91 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > index f73221174a8b..75166a43ffa4 100644
> > > --- a/mm/mmap_lock.c
> > > +++ b/mm/mmap_lock.c
> > > @@ -46,20 +46,40 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> > >  #ifdef CONFIG_MMU
> > >  #ifdef CONFIG_PER_VMA_LOCK
> > >
> > > +/* State shared across __vma_[enter, exit]_exclusive_locked(). */
> > > +struct vma_exclude_readers_state {
> > > +       /* Input parameters. */
> > > +       struct vm_area_struct *vma;
> > > +       int state; /* TASK_KILLABLE or TASK_UNINTERRUPTIBLE. */
> > > +       bool detaching;
> > > +
> > Are these:
> >             /* Output parameters. */
> > ?
>
> Yurp.
>
> Oh you added the comment :) well clearly I should have, will do so.
>
> > > +       bool detached;
> > > +       bool exclusive; /* Are we exclusively locked? */
> > > +};
> > > +
> > >  /*
> > >   * Now that all readers have been evicted, mark the VMA as being out=
 of the
> > >   * 'exclude readers' state.
> > >   *
> > >   * Returns true if the VMA is now detached, otherwise false.
> > >   */
> > > -static bool __must_check __vma_exit_exclusive_locked(struct vm_area_=
struct *vma)
> > > +static void __vma_exit_exclusive_locked(struct vma_exclude_readers_s=
tate *ves)
> > >  {
> > > -       bool detached;
> > > +       struct vm_area_struct *vma =3D ves->vma;
> > > +
> > > +       VM_WARN_ON_ONCE(ves->detached);
> > > +       VM_WARN_ON_ONCE(!ves->exclusive);
> > >
> > > -       detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_=
FLAG,
> > > -                                        &vma->vm_refcnt);
> > > +       ves->detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_REA=
DERS_FLAG,
> > > +                                             &vma->vm_refcnt);
> > >         __vma_lockdep_release_exclusive(vma);
> > > -       return detached;
> > > +}
> > > +
> > > +static unsigned int get_target_refcnt(struct vma_exclude_readers_sta=
te *ves)
> > > +{
> > > +       const unsigned int tgt =3D ves->detaching ? 0 : 1;
> > > +
> > > +       return tgt | VM_REFCNT_EXCLUDE_READERS_FLAG;
> > >  }
> > >
> > >  /*
> > > @@ -69,30 +89,31 @@ static bool __must_check __vma_exit_exclusive_loc=
ked(struct vm_area_struct *vma)
> > >   * Note that this function pairs with vma_refcount_put() which will =
wake up this
> > >   * thread when it detects that the last reader has released its lock=
.
> > >   *
> > > - * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in ca=
ses where we
> > > - * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fa=
tal signal
> > > - * is permitted to kill it.
> > > + * The ves->state parameter ought to be set to TASK_UNINTERRUPTIBLE =
in cases
> > > + * where we wish the thread to sleep uninterruptibly or TASK_KILLABL=
E if a fatal
> > > + * signal is permitted to kill it.
> > >   *
> > > - * The function will return 0 immediately if the VMA is detached, an=
d 1 once the
> > > - * VMA has evicted all readers, leaving the VMA exclusively locked.
> > > + * The function sets the ves->locked parameter to true if an exclusi=
ve lock was
> >
> > s/ves->locked/ves->exclusive
> >
> > > + * acquired, or false if the VMA was detached or an error arose on w=
ait.
> > >   *
> > > - * If the function returns 1, the caller is required to invoke
> > > - * __vma_exit_exclusive_locked() once the exclusive state is no long=
er required.
> > > + * If the function indicates an exclusive lock was acquired via ves-=
>exclusive
> > > + * (or equivalently, returning 0 with !ves->detached),
> >
> > I would remove the mention of that equivalence because with this
> > change, return 0 simply indicates that the operation was successful
> > and should not be used to infer any additional states. To get specific
> > state the caller should use proper individual ves fields. Using return
> > value for anything else defeats the whole purpose of this cleanup.
>
> OK I'll remove the equivalency comment.
>
> >
> > > the caller is required to
> > > + * invoke __vma_exit_exclusive_locked() once the exclusive state is =
no longer
> > > + * required.
> > >   *
> > > - * If state is set to something other than TASK_UNINTERRUPTIBLE, the=
 function
> > > - * may also return -EINTR to indicate a fatal signal was received wh=
ile waiting.
> > > + * If ves->state is set to something other than TASK_UNINTERRUPTIBLE=
, the
> > > + * function may also return -EINTR to indicate a fatal signal was re=
ceived while
> > > + * waiting.
> > >   */
> > > -static int __vma_enter_exclusive_locked(struct vm_area_struct *vma,
> > > -               bool detaching, int state)
> > > +static int __vma_enter_exclusive_locked(struct vma_exclude_readers_s=
tate *ves)
> > >  {
> > > -       int err;
> > > -       unsigned int tgt_refcnt =3D VM_REFCNT_EXCLUDE_READERS_FLAG;
> > > +       struct vm_area_struct *vma =3D ves->vma;
> > > +       unsigned int tgt_refcnt =3D get_target_refcnt(ves);
> > > +       int err =3D 0;
> > >
> > >         mmap_assert_write_locked(vma->vm_mm);
> > > -
> > > -       /* Additional refcnt if the vma is attached. */
> > > -       if (!detaching)
> > > -               tgt_refcnt++;
> > > +       VM_WARN_ON_ONCE(ves->detached);
> > > +       VM_WARN_ON_ONCE(ves->exclusive);
> >
> > Aren't these output parameters? If so, why do we stipulate their
> > initial values instead of setting them appropriately?
>
> I guess it was just to ensure correctly set up but yes it's a bit weird, =
will
> remove.
>
> >
> > >
> > >         /*
> > >          * If vma is detached then only vma_mark_attached() can raise=
 the
> > > @@ -101,37 +122,39 @@ static int __vma_enter_exclusive_locked(struct =
vm_area_struct *vma,
> > >          * See the comment describing the vm_area_struct->vm_refcnt f=
ield for
> > >          * details of possible refcnt values.
> > >          */
> > > -       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &v=
ma->vm_refcnt))
> > > +       if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &v=
ma->vm_refcnt)) {
> > > +               ves->detached =3D true;
> > >                 return 0;
> > > +       }
> > >
> > >         __vma_lockdep_acquire_exclusive(vma);
> > >         err =3D rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> > >                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
> > > -                  state);
> > > +                  ves->state);
> > >         if (err) {
> > > -               if (__vma_exit_exclusive_locked(vma)) {
> > > -                       /*
> > > -                        * The wait failed, but the last reader went =
away
> > > -                        * as well. Tell the caller the VMA is detach=
ed.
> > > -                        */
> > > -                       WARN_ON_ONCE(!detaching);
> > > -                       err =3D 0;
> > > -               }
> > > +               __vma_exit_exclusive_locked(ves);
> > >                 return err;
> >
> > Nice! We preserve both error and detached state information.
>
> :)
>
> >
> > >         }
> > > -       __vma_lockdep_stat_mark_acquired(vma);
> > >
> > > -       return 1;
> > > +       __vma_lockdep_stat_mark_acquired(vma);
> > > +       ves->exclusive =3D true;
> > > +       return 0;
> > >  }
> > >
> > >  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lo=
ck_seq,
> > >                 int state)
> > >  {
> > > -       int locked;
> > > +       int err;
> > > +       struct vma_exclude_readers_state ves =3D {
> > > +               .vma =3D vma,
> > > +               .state =3D state,
> > > +       };
> > >
> > > -       locked =3D __vma_enter_exclusive_locked(vma, false, state);
> > > -       if (locked < 0)
> > > -               return locked;
> > > +       err =3D __vma_enter_exclusive_locked(&ves);
> > > +       if (err) {
> > > +               WARN_ON_ONCE(ves.detached);
> >
> > I believe the above WARN_ON_ONCE() should stay inside of
> > __vma_enter_exclusive_locked(). Its correctness depends on the
> > implementation details of __vma_enter_exclusive_locked(). More
>
> Well this was kind of horrible in the original implementation, as you are
> literally telling the function whether you are detaching or not, and only=
 doing
> this assert if you were not.
>
> That kind of 'if the caller is X do A, if the caller is Y do B' is really=
 a code
> smell, you should have X do the thing.
>
> > specifically, it is only correct because
> > __vma_enter_exclusive_locked() returns 0 if the VMA is detached, even
> > if there was a pending SIGKILL.
>
> Well it's a documented aspect of the function that we return 0 immediatel=
y on
> detached state so I'm not sure that is an implementation detail?
>
> I significantly prefer having that here vs. 'if not detaching then assert=
 if
> detached' for people to scratch their heads over in the function.
>
> I think this detail is incorrect anyway, because:
>
>         if (err) {
>                 if (__vma_exit_exclusive_locked(vma)) {
>                         /*
>                          * The wait failed, but the last reader went away
>                          * as well. Tell the caller the VMA is detached.
>                          */
>                          WARN_ON_ONCE(!detaching);
>                          err =3D 0;
>                 }
>                 ...
>         }
>
> Implies - hey we're fine with err not being zero AND detaching right? In =
which
> case reset the error?
>
> Except when detaching we set TASK_UNINTERRUPTIBLE? Which surely means we =
never
> seen an error?
>
> Or do we?
>
> Either way it's something we handle differently based on _caller_. So it =
doesn't
> belong in the function at all.
>
> It's certainly logic that's highly confusing and needs to be handled
> differently.

Just to be clear, I'm not defending the way it is done before your
change, however the old check for "if not detaching then assert if
detached" makes more sense to me than "if
__vma_enter_exclusive_locked() failed assert that we VMA is still
attached". The latter one does not make logical sense to me. It's only
correct because of the implementation detail of
__vma_enter_exclusive_locked().

>
> >
> > > +               return err;
> > > +       }
> > >
> > >         /*
> > >          * We should use WRITE_ONCE() here because we can have concur=
rent reads
> > > @@ -141,9 +164,11 @@ int __vma_start_write(struct vm_area_struct *vma=
, unsigned int mm_lock_seq,
> > >          */
> > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > >
> > > -       /* vma should remain attached. */
> > > -       if (locked)
> > > -               WARN_ON_ONCE(__vma_exit_exclusive_locked(vma));
> > > +       if (!ves.detached) {
> >
> > Strictly speaking the above check should be checking ves->exclusive
> > instead of !ves.detached. What you have is technically correct but
> > it's again related to that comment:
> >
> > "If the function indicates an exclusive lock was acquired via
> > ves->exclusive (or equivalently, returning 0 with !ves->detached), the
> > caller is required to invoke __vma_exit_exclusive_locked() once the
> > exclusive state is no longer required."
> >
> > So, here you are using returning 0 with !ves->detached as an
> > indication that the VMA was successfully locked. I think it's less
> > confusing if we use the field dedicated for that purpose.
>
> OK changed.
>
> >
> > > +               __vma_exit_exclusive_locked(&ves);
> > > +               /* VMA should remain attached. */
> > > +               WARN_ON_ONCE(ves.detached);
> > > +       }
> > >
> > >         return 0;
> > >  }
> > > @@ -151,7 +176,12 @@ EXPORT_SYMBOL_GPL(__vma_start_write);
> > >
> > >  void vma_mark_detached(struct vm_area_struct *vma)
> > >  {
> > > -       bool detached;
> > > +       struct vma_exclude_readers_state ves =3D {
> > > +               .vma =3D vma,
> > > +               .state =3D TASK_UNINTERRUPTIBLE,
> > > +               .detaching =3D true,
> > > +       };
> > > +       int err;
> > >
> > >         vma_assert_write_locked(vma);
> > >         vma_assert_attached(vma);
> > > @@ -160,18 +190,26 @@ void vma_mark_detached(struct vm_area_struct *v=
ma)
> > >          * See the comment describing the vm_area_struct->vm_refcnt f=
ield for
> > >          * details of possible refcnt values.
> > >          */
> > > -       detached =3D __vma_refcount_put(vma, NULL);
> > > -       if (unlikely(!detached)) {
> > > -               /* Wait until vma is detached with no readers. */
> > > -               if (__vma_enter_exclusive_locked(vma, true, TASK_UNIN=
TERRUPTIBLE)) {
> > > -                       /*
> > > -                        * Once this is complete, no readers can incr=
ement the
> > > -                        * reference count, and the VMA is marked det=
ached.
> > > -                        */
> > > -                       detached =3D __vma_exit_exclusive_locked(vma)=
;
> > > -                       WARN_ON_ONCE(!detached);
> > > -               }
> > > +       if (likely(__vma_refcount_put(vma, NULL)))
> > > +               return;
> > > +
> > > +       /*
> > > +        * Wait until the VMA is detached with no readers. Since we h=
old the VMA
> > > +        * write lock, the only read locks that might be present are =
those from
> > > +        * threads trying to acquire the read lock and incrementing t=
he
> > > +        * reference count before realising the write lock is held an=
d
> > > +        * decrementing it.
> > > +        */
> > > +       err =3D __vma_enter_exclusive_locked(&ves);
> > > +       if (!err && !ves.detached) {
> >
> > Same here, we should be checking ves->exclusive to decide if
> > __vma_exit_exclusive_locked() should be called or not.
>
> Ack, changed.
>
> >
> > > +               /*
> > > +                * Once this is complete, no readers can increment th=
e
> > > +                * reference count, and the VMA is marked detached.
> > > +                */
> > > +               __vma_exit_exclusive_locked(&ves);
> > >         }
> > > +       /* If an error arose but we were detached anyway, we don't ca=
re. */
> > > +       WARN_ON_ONCE(!ves.detached);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.52.0
>
> Cheers, Lorenzo
