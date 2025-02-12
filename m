Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5720B80A
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373681; cv=none; b=WU9oAH7kOE9cubCJ7YkDiLsIxvNHjUEozeKeuzCV1YcLWJ4X0kf4LJFduoOizez3mdLd++3CvqsW81CcBAIjBSHcaE/gX6+tB4nOY00rLuk/lLT7409infE4GwYR/O6WsYyMeILYRTOP4iD+F3AOuUtO6/l1VpIs3uXAeMfveCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373681; c=relaxed/simple;
	bh=agI0Ag5i8SFSLdkbUcYoULvVB2ybUsCy4MD9WvwqyaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksB8X8TscH1QTwGCXlT+mT9Jl089xmvnN6XGc+0ZE9t++nJQEAsAT7rzHqmjORfUwRCc4AJkUvQwSVJfDILLQPtiUEAys8rWwwDjHXvnnR8kNYrlW1/GnKUMaKAun6CYU0V5sIrHi4YAZ7bi6opHOcZJ1ALWv0RCdInsK+uaguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwWmBSPS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwWmBSPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739373678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SjnwqfCvw+/wca/T+W1y2/q0eFnKY4cpQjHVqCa1Qg=;
	b=UwWmBSPSQuMbNJQraRLmi867XJHDI08aTC2ipGK4RIwGiaVnts4WzIgAglC6Fx64GNg5+v
	6np8DmBcbmh+x/63zsWsOyUBzqbLHiTIpZIMlhwOep5ULdyh3frwBFTXQaJI7CfnPIVURR
	c4j7rtd5OPdab3f3+FwKpEmSjB5cI9A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-l7OLQW7NOsmoigz7aargfg-1; Wed, 12 Feb 2025 10:21:17 -0500
X-MC-Unique: l7OLQW7NOsmoigz7aargfg-1
X-Mimecast-MFC-AGG-ID: l7OLQW7NOsmoigz7aargfg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so14740047a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 07:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373676; x=1739978476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SjnwqfCvw+/wca/T+W1y2/q0eFnKY4cpQjHVqCa1Qg=;
        b=ouIMsJBMWY2WxN/XR1iAEXMywuu+iYMmqnFoqvT/ztow4J7+FRUqJpWKNpvwRkxgnv
         1wTVI5SSdATjAlc+mJa171PzqmOe5jENpL48g0NX91uSl5T0n4JGeH77cd2hrXla7AjH
         QnKUlBRIJlRDGmsdw1p8WrJSDX4upmmHcYsyiUgMCZ7Oxvt06oGclVczPWoB94416oXY
         7OXO5m2MIpdMo9S8USyCNktQSuchptX7lZHM/lcNQuB83/nYvtGgK1e6Xeg2dITUd/8a
         LngDM909uWbAn2ZAOrkEUdrvjWZmPKJoRf3E4v9xpD2NdURhVu/AUY2jff246gYWIS2f
         uvBw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWZwoOIQh7iAqKNwJ5l4HzL3JPQVwKwH1viuso51IMMqWdTF+YE3rbrhk0Q3Vz8r1yet+BqR+tdkZ6TjSiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy71pdXq86tR8PAFkE1XmMEzgUZYhykMeQb5E9SKCtcJQkxRGVy
	psGZu5/z0lMYbvL8VQ8jvOfpu9z5B09IMJq6IBWloCj8wzRvnMXkP4blwQbF36OAvymFnlnS+FE
	BbavEIrD16fw9OD1nLpdsWOqiKI5/gJrYNh7w2JzSrb1x98Kiaap++jEIYYRVjBpeji2fdWoW14
	m2XXQW2MWb2QUmXNfXVXNBSK2oIz85YFz1JDjQ7hM=
X-Gm-Gg: ASbGncuuXbIQvlhW6iekY/yqEjc1Mo+HRkN3hUbLFEFlSEbAXESFpuECI9TxgleasCr
	fh2S9FeraVUTpvTz1MbUT9L4lHj4O4SmvUurSyAcTwk/JZ7wUEcfXvQ5V9QFVrauEu/4uxL3Iw/
	mz0rJIIIGwhgbcbJI47k0=
X-Received: by 2002:a17:90b:5243:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-2fbf5be7625mr6213596a91.14.1739373676183;
        Wed, 12 Feb 2025 07:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzqj+9MNhx5YqwWgASHcEcT64gya4XQbZALAQ0AjXWJ91Wy7sgAiml+qrkUVIGpAu2u0D4su+WH+tHzVa0gcQ=
X-Received: by 2002:a17:90b:5243:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2fbf5be7625mr6213558a91.14.1739373675778; Wed, 12 Feb 2025
 07:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de> <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de> <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
In-Reply-To: <20250212151108.jI8qODdD@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 12 Feb 2025 12:21:04 -0300
X-Gm-Features: AWEUYZmr7W8IxxCGlV3ssnjqNEJrB8w4TfvAhZ-CqLD-MzcLv67tZOC2062OTBo
Message-ID: <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, 
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BphR_T7t73cy6uRnWTVNJ0O_UqfIH1nWwi5-Cfvxm8A_1739373676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:11=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-02-12 08:56:47 [-0300], Wander Lairson Costa wrote:
> > > What disables preemption? On PREEMPT_RT the spin_lock() does not disa=
ble
> > > preemption. You shouldn't spin that long. When was interrupt schedule=
d.
> > > _Why_ is the interrupt delayed that long.
> > >
> > When I was using trace-cmd report -l, it omitted some fields, one of
> > them is preempt-lazy-depth (which was something new to me), and it seem=
s
> > this is what affects interrupts. It comes from here [1]. I had the logs=
,
> > but the machine went under maintenance  before I could save them. Once
> > it comes back, I can grab them and post here.
> >
> > [1] https://elixir.bootlin.com/linux/v6.13.2/source/drivers/net/etherne=
t/intel/igbvf/netdev.c#L1522
>
> If you do send patches against mainline please test against mainline. As
> of today we have preempt-disable and migrate-disable depth. We don't
> do lazy-depth anymore, we just have a bit now (which is [lLbB]).
> The referenced line will only disable migration, not preemption.
>
> It is important to understand what exactly is going on.
>

I forgot to mention. For this specific test, I had to test with an
older kernel because of an ongoing
issue with this machine when running recent kernels (this is why the
machine went to maintenance, btw).
I will reproduce it again. For patches, I did test them against the
latest mainline before submitting.

> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/=
ethernet/intel/igb/igb_main.c
> > > index d368b753a4675..6fe37b8001c36 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -912,7 +912,7 @@ static int igb_request_msix(struct igb_adapter *a=
dapter)
> > >     struct net_device *netdev =3D adapter->netdev;
> > >     int i, err =3D 0, vector =3D 0, free_vector =3D 0;
> > >
> > > -   err =3D request_irq(adapter->msix_entries[vector].vector,
> > > +   err =3D request_threaded_irq(adapter->msix_entries[vector].vector=
, NULL,
> > >                       igb_msix_other, 0, netdev->name, adapter);
> > >     if (err)
> > >             goto err_out;
> > >
> > > just to see if it solves the problem?
> > >
> > I have two test cases:
> >
> > 1) Boot the machine with nr_cpus=3D1. The driver reports "PF still
> > resetting" message continuously. This issue is gone.
>
> good.
>
> > 2) Run the following script:
> >
> >     ipaddr_vlan=3D3
> >     nic_test=3Dens14f0
> >     vf=3D${nic_test}v0 # The main testing steps:
> >     while true; do
> >         ip link set ${nic_test} mtu 1500
> >         ip link set ${vf} mtu 1500
> >         ip link set $vf up
> >         # 3. set vlan and ip for VF
> >         ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
> >         ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
> >         ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
> >         # 4. check the link state for VF and PF
> >         ip link show ${nic_test}
> >         if ! ip link show $vf | grep 'state UP'; then
> >             echo 'Error found'
> >             break
> >         fi
> >         ip link set $vf down
> >     done
> >
> > This one eventually fails. It is the first time that one works and the
> > other fails. So far, it has been all or nothing. I didn't have time yet=
 to
> > investigate why this happens.
>
> "eventually fails". Does this mean it passes the first few iterations
> but then it times out? In that case it might be something else
>
Yes. Indeed, might be due something else. I will perform further investigat=
ion
when I get the machine back.

> I managed to find a "Intel Corporation I350 Gigabit Network Connection
> (rev 01)" and I end up in a warning if I start the script (without the
> while true):
>
> |8021q: adding VLAN 0 to HW filter on device eno0v0
> |igbvf 0000:08:10.0: Vlan id 0 is not added
> |igb 0000:07:00.0: Setting VLAN 3, QOS 0x0 on VF 0
> |igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
> |------------[ cut here ]------------
> |WARNING: CPU: 25 PID: 3013 at drivers/net/ethernet/intel/igbvf/netdev.c:=
1777 igbvf_close+0x111/0x120
> =E2=80=A6
> |CPU: 25 UID: 0 PID: 3013 Comm: ip Not tainted 6.14.0-rc1-rt1+ #186 PREEM=
PT_RT+LAZY 39474a76e7562bb76173f4b98cf194301d39bf7f
> |igbvf 0000:08:10.0: Link is Up 1000 Mbps Full Duplex
> |---[ end trace 0000000000000000 ]---
> |igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
> |igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
> |igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
> |8021q: adding VLAN 0 to HW filter on device eno0v0
> |igb 0000:07:00.0: VF 0 attempted to override administratively set VLAN t=
ag
> |Reload the VF driver to resume operations
> |igbvf 0000:08:10.0: Link is Up 1000 Mbps Full Duplex
> |igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
>
> and the state is down ('Error found' is printed). But if I do it
> manually, line by line, then it all passes without the warning and the
> state of the VF device is up.
>
> Sebastian
>

