Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F1584949
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Sep 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964266; cv=pass; b=XQeED29H3ssFI9+7pvQzn/Y+OqFNC0jqz2zIz/OqmWvf5nZ5ESZzb8uPeV1G5iSgZj7FIyr6Z2u6Goxws2kk6csc/q8StUopGy9ZKf6j8XG7Gs/gf2MsgUoMNNk8BsUJFFHg2JyHwNlctWJ9mEvEF8PumJDB+9u6xuFE8cFI7jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964266; c=relaxed/simple;
	bh=bL3FhBHPAN/gO0KYh+II+j6VXDmseoWIh8krisyD6DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZl/EeCR2FwLwVCZ2MkrBj4lbwJ2tVz5F46yvHUE5zmf2GsJ45r0GJxXjxgckU2XMBkFrMhTtvDo6RWZZZNasmEHL3t3M34lraCvDNCVbQrAfCRjpbJJ/9O/XW2NGh4sytb197dDCTz8BLyHeagQHl6f4Bh3Bo1Nc74n98VNO7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhyQpkI3; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhyQpkI3"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250f28f1cdso973734966b.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Sep 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964263; cv=none;
        d=google.com; s=arc-20260327;
        b=lCB8JyPxmSgb1QoGXLUDGmt15iQLhx2XOFicooNvfrX1g66INn+luagYzCaTVWaOkl
         0NwHoKjFcC0AV7KlWwuOM1k2fdqlBVJbHERMyFnEapKFadplKllVx60l9Un++l1p6D1Q
         szgF/NahsWM46/5zbZLy9hFdme0hOH7+vcRnPwB60JLlcH79G3WhdA1Fq1vEb3f9Ctc4
         K86zltrw1jIC2iouz1B5XIoHbwDz03wGn8tuL4Od4QIvfM4PbCrnbvqY3e2fcdfY+lmc
         nsFO+tJ6bwsXooiZciy5uER//UTQdx3DQtsihUcgdWhwhyjErcAzXHX0aal+4x+LJkDI
         1J6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        fh=Zsl/FzwO+F7uhli17LvurrVEVajqTaKmEzLsBKbau+c=;
        b=hlUZ8uASaexvo2rDqNtdVUKadGf28fu7aJZZOZ1bndOBjlYoDxya5mfI+BpF8Rb2z4
         W9w+RtFiHGarLd9WOYeT4/aLQIf/0l8ZTH5nnrboV/2Gpd6/9KJ0jPETd7eLo4meSYtJ
         hBvr/zv53BbKEPBkNfhHipu/DIAMWsNdYlb5dgJI/n4WDtOKwx6mxeS22OD1fakBGjoL
         4gg3U9K4SKMoN4XLKz9y9oBTbvaNTOQi7ce/wsNUUCniTiJQvPhxwQkeMFavk/ofUz2a
         VxYlf+Xcfd0sZfie5DVk4Vo2aGizVpKgxAhMtHRnLCeMs42WIr12Pe9tcbosc9nmoVrY
         +ClQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788964263; x=1789569063; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=jhyQpkI386OjWETMDxvxKgYpuYHoX+hKQrLKitSOmTUfIcMnsAwVi/iOJdJi00wxGE
         rpj9Yj7LKBmYB26BqkDyLl4VShKFvoRsgzjUHVhwLkJkxqhLsuOBIN81MBXcBcJqOCAK
         d9jTVi1YxDF5RCoQYaTnGEnj0fWAfZhYX3BVB0PgBYISUsbj7yq69EoqlQelkR0XYeaP
         kHpbZ1DYP7rcivfqB4ET+ML9q3OzOfMbN/kFyhtaw9Kdkz5b0jecbn9gFAqEpo+nPjP2
         asOZ4yrK/h7LChVbRW5YQbzTUSQsLtin0K/IEhkO3MLPYa8l0wZt+vj3TfEIO1JneC6d
         0fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964263; x=1789569063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=i5wH3WZKUYMtY9ossgIRj4QAz2jgqvGK6O7Gfih+wXxOAaDat/MuhNXsmo23AzjCTc
         +VLrq+N0955lvODjbWyB//DA0YVvzN12OMNJup0tmBplTWefKFuAj52ltvF/eLZnlQak
         kQeqJykAY9De61Q49xUvPDvTZ/6L3fgIC872+AlF/FodYA8JqRupuMnkfnX+szStPos1
         fUM8ylxELztU+NRV1qZHD0SzY2jrN4aK7WDbElrDDV2pUceyWwn7owjPwVqlq75dBvTr
         y569FHc5Iu5Ws7OFeFmymeNwOYqxxYtd/07Gvq3n5A0hiNxcaNlYwkU5KtdwLGw0wiDk
         mZ9g==
X-Forwarded-Encrypted: i=1; AKwUvBxmN7DlvHe07VOQ4D7HDtSZSCHEAZ4OH64IPBydbzW82N1lhRNmrT04FOfd7Mx3JTFJHSWhsB3yyWoBO6ldLA==@lists.linux.dev
X-Gm-Message-State: AFuF++lZD0e1mBuuCYPZvoac3rCiT3L1+v/v49uNghBBrIjkUWZrfoce
	fLyrEPBg8g0hQ/7lH0kClKcXS99sHTA8SD67lNmHJdxCQOJsJDVlhJE1Nr099a40TIAWvFVJBeA
	Gh3MUcplWo1hLPfKRCCzh7wA/vG6a19c=
X-Gm-Gg: AYBFou0X5sUIM6jrV2EM83zS1bY74ZWq7lk8gWj+ScJt5NfCVdNMFllOsxop8p0Ti75
	8WBRUOSKeARn8hGrEwhOfghwBWTG/kL6C9o2APHU0XC3ZS2oloDq6YOnoEnyWoK9H3QD/1+t/+U
	dCPWg65kqy+z9Vstb2aphk/E6DCP1+8weKYTcwFaAlKbB0tINXj8mQsdVvmDg4C684ZPuWLtLe8
	fk+qc/oleaN5UiRDFPm3JVZvYGamIRTMRoO0Pntgqix8FJI0+ZuU7Ok4xM1pYhOJZtx4qwGKOdA
	B/cWttYCGD0hzyjZe4FvFwXBhoweoJMndYxCRrK2QL/bQKX9Itbwgg/NdnC0gFeodDgAKi8=
X-Received: by 2002:a17:907:3f2a:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c28fb400053mr726589666b.30.1788964261711; Wed, 09 Sep 2026
 07:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <aqFebI06nXUccuwt@thinkstation>
In-Reply-To: <aqFebI06nXUccuwt@thinkstation>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 9 Sep 2026 15:30:48 +0100
X-Gm-Features: AcwNN1XiH3nsxsI43wM30YdmALjDY-XF6jmsUMiyceN_7aAAFdPSS0ZgK9KjeOs
Message-ID: <CANk7y0htDA4zC6tK=Fi5H9bbFvQzOEJ57NtxDYhRLuMAxgEe3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Harry Yoo <harry@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:26=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 05:27:50AM -0700, Puranjay Mohan wrote:
> > ---
> >  kernel/rcu/Kconfig |   6 +++
> >  kernel/rcu/rcu.h   |  11 ++++
> >  kernel/rcu/tree.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
> >  kernel/rcu/tree.h  |   6 +++
> >  4 files changed, 143 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f15da8038d0ba..1a5fb3156c062 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
> >  config RCU_NEED_SEGCBLIST
> >       def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
> >
> > +# The deferral (and the IRQ_WORK it uses) is only needed where call_rc=
u() /
> > +# call_srcu() can be invoked while a callback-list operation is in fli=
ght.
> > +config RCU_DEFER
> > +     def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> > +     select IRQ_WORK
>
> nit: I don't think this config belongs to RCU.
> Do we really need this when majority of kernels enable those?

Paul was worried about some embedded systems paying a performance
penalty as they might not enable these but would still use RCU.

>
> >  config RCU_FANOUT
> >       int "Tree-based hierarchical RCU fanout value"
> >       range 2 64 if 64BIT
> > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_ca=
llback_t func, bool lazy_in)
> >       local_irq_restore(flags);
> >  }
> >
> > +/*
> > + * Stage @head for this CPU's irq_work to re-issue once interrupts are=
 on.  Only
> > + * the drain side takes a lock, so this stays safe from NMI.
> > + */
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > +
> > +     /*
> > +      * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> > +      * drain.  Re-queuing would livelock it, so drop the callback; an=
 NMI
> > +      * cannot loop, so let it through.
> > +
> > +      */
> > +     if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> > +             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > +                       "call_rcu() re-entered during callback drain; l=
eaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > +             irq_work_queue(&rdp->defer_work);
>
> Should RCU wait for the IRQ work to be processed during e.g.)
> rcu_barrier()?

Yes it should and it does, rcu_barrier() now enqueues these deferred
callbacks from this list before doing the other barrier logic.

Thanks
