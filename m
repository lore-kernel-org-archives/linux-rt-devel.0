Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C11D90B9
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Feb 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874589; cv=none; b=oYYDMP0no+6l8VRdd3FUEm0C2ffkyJqixIvhe7KVCc8C1Xe0eMGKwHX1AhBZ4DnfVnfYQKpsiSiVJ29OtcmzQ4L6w4/KTKB/Hd6vrHQVSoyl6lubLjGxVEH6rBzyy86WWv4VyXwxD11nW43EM7Std3bCdVe5HqVaLveHJ1bmEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874589; c=relaxed/simple;
	bh=x9xBWbKR9FSC9kjmPJZEieXZvsaIbjVadh88+dHvVUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr8K5HoXOKf547NQWLJQndKUa8yMM+eD7eoJApyNw1MQkVJ7tkKaHa+MOKmEy91O5dle/WEPHo2fb/RNiLljEM4VIKUXI9SxrkcbQt2d8dAcOlBg+6T60Z7FR+dfPgGw/7GH4NEzwTtncleWOladtoTJW8owhZvg5jZo798kBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JL9kp3/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL9kp3/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738874584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o44+IGhP6ydLBPNjYW923/9bqK+JwHmK/6LB/+5nxFc=;
	b=JL9kp3/MptYgRJ9buqApMnrCYuY9LmKzeiXWQ7mXGxctfXGT6Jpcirxpz21nThnhwm9Mmk
	JHuPdrrk9AfvTi5uzEugIvZjjGYEMKI2A2UeYS+gfU2LGwXUu3zKFcE827EraqAKQYahQd
	5gYF3e4PGvrGsyI2E6lho6pAsllVWgE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-nC_q0_11NkW5Yav8_Cpmkw-1; Thu, 06 Feb 2025 15:43:02 -0500
X-MC-Unique: nC_q0_11NkW5Yav8_Cpmkw-1
X-Mimecast-MFC-AGG-ID: nC_q0_11NkW5Yav8_Cpmkw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa228b4143so334631a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 06 Feb 2025 12:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738874580; x=1739479380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o44+IGhP6ydLBPNjYW923/9bqK+JwHmK/6LB/+5nxFc=;
        b=u0D6NECBvmIvuTbX5hLhJvvqR57KDBnwSZ+QF3AHY/sXZUyljj9EBtOqRyuChLConn
         bVymAM7+KFWkPy//oUQVja7qQ5XS+PCYj6LXO6OFWJYJvMLa2m+BozHollzbjhxEQDNx
         0L9hnfQNU0GAckTbbWpYUlDCka8USf12GKanUMQ9+axmaDqEd0S6GMaqc4AiYOj99nNw
         N9T1KUKpV0A8mKAFkBKQlQBaXFCMY6HENQsnlqZnEGNdZXGJye0wctJbw9MzcGl2Fpkq
         A3dt112WuP9jcIu6LpfxH8djTemkRmJeYJEECdwBHRErtDwNAyL4DqHFUjNRQnUrNrEn
         G8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXHIRkDGmHRtMhn0Sq71RnQ9zNBj4YPz0DQtX5dMiNCApGBnPX/PVVyBHiWTPViljc5BQIYc7lII5/mq3Ck8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YygSuq5nG9MeFuR44pCuNYkunOFKd3qAjHpz3wM2jST6KZHvyHU
	nfah44fb2qvXZ6HlxaoTI//vH0Cw6zeHUYMztTXusyIDFwxchm/ZgkIjoMWCfPjQnIUVjEeOsf5
	s/D7wcmzmTyYsObjdGwAikAukjun8Xxj4rwpKa6CM8oEEZZFbp+iHweYwd5QI4mKgAEzremhccb
	hp3710dNui/S9U3rnHjf7pKsn4w9pWzljSypxzeo0=
X-Gm-Gg: ASbGncvJtyArrURTEJPmkS+mduw9SMMndDtYX7VG3BdPOeE7zYxLngZwRDlzOK5QLbf
	p/il0/ycZNjIpb74tnxyopfOn0W9WXjJVMlVGJkDyJYYOgwpRnPbEZysNXiFPiQ==
X-Received: by 2002:a17:90a:a418:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-2fa1d9f0e83mr2645071a91.17.1738874580162;
        Thu, 06 Feb 2025 12:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz/38BwZpTvxx9BMtt80dLusbYfsGW0fQ0MGyJaew8GIRPM6BAguBHLFDMn+q7sZvjUuEINXmUNPKiJEdABt0=
X-Received: by 2002:a17:90a:a418:b0:2fa:1d9f:c80 with SMTP id
 98e67ed59e1d1-2fa1d9f0e83mr2645032a91.17.1738874579786; Thu, 06 Feb 2025
 12:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de> <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
In-Reply-To: <20250206115914.VfzGTwD8@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 6 Feb 2025 17:42:48 -0300
X-Gm-Features: AWEUYZm3Vn1bcNzd0wzMhXmmKRVK6lANLUYiXkH_vBx04SuSlZSv1yv9cHr5N74
Message-ID: <CAAq0SU=yK0Z9jm_50vVsUj9L9VtK1D6ymv+8b+=i_ZqWXCUQ3g@mail.gmail.com>
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, 
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T3jX3_O0_UID3y_gjBupJrdr5r0muOkWEMxyA9AudWw_1738874580
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:59=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-02-05 17:08:35 [-0300], Wander Lairson Costa wrote:
> > On Wed, Feb 05, 2025 at 10:48:18AM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2025-02-04 09:52:36 [-0800], Tony Nguyen wrote:
> > > > Wander Lairson Costa says:
> > > >
> > > > This is the second attempt at fixing the behavior of igb_msix_other=
()
> > > > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > > > concerns raised by Sebastian [3].
> > >
> > > I still prefer a solution where we don't have the ifdef in the driver=
. I
> > > was presented two traces but I didn't get why it works in once case b=
ut
> > > not in the other. Maybe it was too obvious.
> >
> > Copying the traces here for further explanation. Both cases are for
> > PREEMPT_RT.
> >
> > Failure case:
> >
> > kworker/-86      0...1    85.381866: function:                   igbvf_=
reset
> > kworker/-86      0...2    85.381866: function:                      e10=
00_reset_hw_vf
> > kworker/-86      0...2    85.381867: function:                         =
e1000_check_for_rst_vf
> > kworker/-86      0...2    85.381868: function:                         =
e1000_write_posted_mbx
> > kworker/-86      0...2    85.381868: function:                         =
   e1000_write_mbx_vf
> > kworker/-86      0...2    85.381870: function:                         =
   e1000_check_for_ack_vf // repeats for 2000 lines
>
> So it repeats because it waits for the bit. It waits for the interrupts.
>

Exactly. Although I am not familiar with the hardware, I understand
the interrupt sets the bit it is waiting for.

> > ...
> > kworker/-86      0.N.2    86.393782: function:                         =
e1000_read_posted_mbx
>
> Is this 2 the migrate-disable or preempt-disable counter? Because you
> should get preempted based on that N.
>
> > kworker/-86      0.N.2    86.398606: function:                      e10=
00_init_hw_vf
> > kworker/-86      0.N.2    86.398606: function:                         =
e1000_rar_set_vf
> > kworker/-86      0.N.2    86.398606: function:                         =
   e1000_write_posted_mbx
> > irq/65-e-1287    0d..1    86.398609: function:             igb_msix_oth=
er
>
> So the kworker leaves and immediately the interrupt gets on the CPU.
>
> > irq/65-e-1287    0d..1    86.398609: function:                igb_rd32
> > irq/65-e-1287    0d..2    86.398610: function:                igb_check=
_for_rst
> > irq/65-e-1287    0d..2    86.398610: function:                igb_check=
_for_rst_pf
> > irq/65-e-1287    0d..2    86.398610: function:                   igb_rd=
32
> > irq/65-e-1287    0d..2    86.398611: function:                igb_check=
_for_msg
> > irq/65-e-1287    0d..2    86.398611: function:                igb_check=
_for_msg_pf
> > irq/65-e-1287    0d..2    86.398611: function:                   igb_rd=
32
> > irq/65-e-1287    0d..2    86.398612: function:                igb_rcv_m=
sg_from_vf
> > irq/65-e-1287    0d..2    86.398612: function:                   igb_re=
ad_mbx
> > irq/65-e-1287    0d..2    86.398612: function:                   igb_re=
ad_mbx_pf
> > irq/65-e-1287    0d..2    86.398612: function:                      igb=
_obtain_mbx_lock_pf
> > irq/65-e-1287    0d..2    86.398612: function:                         =
igb_rd32
> >
> > In the above trace, observe that the ISR igb_msix_other() is only
> > scheduled after e1000_write_posted_mbx() fails due to a timeout.
> > The interrupt handler should run during the looping calls to
> > e1000_check_for_ack_vf(), but it is not scheduled because
> > preemption is disabled.
>
> What disables preemption? On PREEMPT_RT the spin_lock() does not disable
> preemption. You shouldn't spin that long. When was interrupt scheduled.
> _Why_ is the interrupt delayed that long.
>

In RT, it is a thread. To simplify the process of simulating the bug,
I booted the kernel with the parameter nr_cpus=3D1. Since preemption is
disabled in this configuration, the ISR (Interrupt Service Routine) is
not scheduled immediately and is deferred until later.

From what I recall, I traced the issue starting from the netapi and
ksoftirqd components. To ensure accuracy, I will set up a machine and
verify the behavior again.

> > Note that e1000_check_for_ack_vf() is called 2000 times before
> > it finally times out.
>
> Exactly.
>
> > Sucessful case:
> >
> >       ip-5603    0...1  1884.710747: function:             igbvf_reset
> >       ip-5603    0...2  1884.710754: function:                e1000_res=
et_hw_vf
> >       ip-5603    0...2  1884.710755: function:                   e1000_=
check_for_rst_vf
> >       ip-5603    0...2  1884.710756: function:                   e1000_=
write_posted_mbx
> >       ip-5603    0...2  1884.710756: function:                      e10=
00_write_mbx_vf
> >       ip-5603    0...2  1884.710758: function:                      e10=
00_check_for_ack_vf
> >       ip-5603    0d.h2  1884.710760: function:             igb_msix_oth=
er
> >       ip-5603    0d.h2  1884.710760: function:                igb_rd32
> >       ip-5603    0d.h3  1884.710761: function:                igb_check=
_for_rst
> >       ip-5603    0d.h3  1884.710761: function:                igb_check=
_for_rst_pf
> >       ip-5603    0d.h3  1884.710761: function:                   igb_rd=
32
> >       ip-5603    0d.h3  1884.710762: function:                igb_check=
_for_msg
> >       ip-5603    0d.h3  1884.710762: function:                igb_check=
_for_msg_pf
> >       ip-5603    0d.h3  1884.710762: function:                   igb_rd=
32
> >       ip-5603    0d.h3  1884.710763: function:                igb_rcv_m=
sg_from_vf
> >       ip-5603    0d.h3  1884.710763: function:                   igb_re=
ad_mbx
> >       ip-5603    0d.h3  1884.710763: function:                   igb_re=
ad_mbx_pf
> >       ip-5603    0d.h3  1884.710763: function:                      igb=
_obtain_mbx_lock_pf
> >       ip-5603    0d.h3  1884.710763: function:                         =
igb_rd32
> >
> > Since we forced the interrupt context for igb_msix_other(), it now
> > runs immediately while the driver checks for an acknowledgment via
> > e1000_check_for_ack_vf().
>
> Is this still RT or non-RT? I'm asking because igbvf_reset() is invoked
> in ip's context and not in a worker. Also igb_msix_other() runs with a
> 'h' so it is not threaded.
>

This is RT with this patch series applied.

> I have a theory of my own, mind testing
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index d368b753a4675..6fe37b8001c36 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -912,7 +912,7 @@ static int igb_request_msix(struct igb_adapter *adapt=
er)
>         struct net_device *netdev =3D adapter->netdev;
>         int i, err =3D 0, vector =3D 0, free_vector =3D 0;
>
> -       err =3D request_irq(adapter->msix_entries[vector].vector,
> +       err =3D request_threaded_irq(adapter->msix_entries[vector].vector=
, NULL,
>                           igb_msix_other, 0, netdev->name, adapter);
>         if (err)
>                 goto err_out;
>
> just to see if it solves the problem?
>

Sure. I will do it and report the results back.

> >
> > > In the mean time:
> > >
> > > igb_msg_task_irq_safe()
> > > -> vfs_raw_spin_lock_irqsave() // raw_spinlock_t
> > > -> igb_vf_reset_event()
> > >   -> igb_vf_reset()
> > >     -> igb_set_rx_mode()
> > >       -> igb_write_mc_addr_list()
> > >          -> mta_list =3D kcalloc(netdev_mc_count(netdev), 6, GFP_ATOM=
IC); // kaboom?
> >
> > Perhaps the solution is to preallocate this buffer, if possible.
> > Doing so would significantly simplify the patch. However, this
> > would require knowing when the multicast (mc) count changes.
> > I attempted to identify this but have not succeeded so far.
> >
> > >
> > > By explicitly disabling preemption or using a raw_spinlock_t you need=
 to
> > > pay attention not to do anything that might lead to unbounded loops
> > > (like iterating over many lists, polling on a bit for ages, =E2=80=A6=
) and
> > > paying attention that the whole API underneath that it is not doing t=
hat
> > > is allowed to.
> >
> > I unsure if I understood what you are trying to say.
>
> The moment you start disabling preemption/ use raw_spin_lock_t you need
> to start about everything underneath/ everything within this section.
> While if you keep using spinlock_t you don't have to worry *that* much
> and worry if *this* will break PREEMPT_RT. Not to worry whether or not
> it is okay to allocate memory or call this function because it might
> break RT.
> OR if netdev_mc_count() returns 1 you loop once later and this costs you
> 1us. If it returns 100, you loop 100 times and it costs how much
> additional time?
>
Understood now. Thanks.

> Sebastian
>

