Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C52147E4
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Feb 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843161; cv=none; b=HPsnCbhMecmmRFD6UFwrKxSVfJ7y1zgmKdqInN5rWoo0trnqNpz7kKUFMCHPjuZLH8J9wzUo6NUq35UdZ0D/0fpAKoLKIeUUiIfAhHFUQxCbagi+oNFd7k5K7AjCbFbQgpXdoCXrPgGg5HiEbDmwKsN8tlrCKVXZmn7mKXfCHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843161; c=relaxed/simple;
	bh=B7lqm2CqCjhjsY5G2ED6FXRhnFIBfUjR+diro4RnXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqtssBLx3E8qPMJ0UewUeLT+TetIoLmeM/wpKmlCnvdaMORO77bO7whN13E0w8WCFy88FIONTi2fuHx21Q/0HA2Sw620XL50hOiRLvNI/AfBgXABStDA0WQi7EOmTWKTS+Mo4phZG6sG76WCj3EE5/puZW7rpTjax8WFoP9z/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PULlTc8H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+RQzcgJx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PULlTc8H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+RQzcgJx"
Date: Thu, 6 Feb 2025 12:59:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738843156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+Q3g/LKmW5EprLccr/OyJ8cK4Hjs9YGfbXWpaSvKI=;
	b=PULlTc8HpZZHsHYeUdtmmUZG4P3ILiGojrhHBCeZPH9UH7TJZvTPuU1/pBfeUDC9xaiak/
	qPM24f2MTB98ouJ1804SYLK0AvdJC07WA98WIOD0D8Csw9F3Sg0dBplVPj9IhC7Ich/0oD
	VFynXBxlfO+aOWI1Jk5q9sAy2V8gsrUamRpEZonqy1iuia01b/PmZTVgpFVTxkNNQhF1/U
	EYrcNy2LGjAxnPT8kMqiQdoejI0cSrGvrTeVaMGHCWGJJveHkTO9rs3EhOJY0I9rofvQsK
	f+9GUxrj5Jdk3JpgsSLRRunKC+POYtOmdwNQ98BqDCg3Ws2vx5u1rS0g6gjclQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738843156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+Q3g/LKmW5EprLccr/OyJ8cK4Hjs9YGfbXWpaSvKI=;
	b=+RQzcgJx2+cuaEju+YBzz0qLHsUZbbrn3pBy/hlP9IzDiZ+oJMGE8VPkHZE9+Qvtg+JIPs
	lgCMVitV+nCJXdCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250206115914.VfzGTwD8@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>

On 2025-02-05 17:08:35 [-0300], Wander Lairson Costa wrote:
> On Wed, Feb 05, 2025 at 10:48:18AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-02-04 09:52:36 [-0800], Tony Nguyen wrote:
> > > Wander Lairson Costa says:
> > >=20
> > > This is the second attempt at fixing the behavior of igb_msix_other()
> > > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > > concerns raised by Sebastian [3].
> >=20
> > I still prefer a solution where we don't have the ifdef in the driver. I
> > was presented two traces but I didn't get why it works in once case but
> > not in the other. Maybe it was too obvious.
>=20
> Copying the traces here for further explanation. Both cases are for
> PREEMPT_RT.
>=20
> Failure case:
>=20
> kworker/-86      0...1    85.381866: function:                   igbvf_re=
set
> kworker/-86      0...2    85.381866: function:                      e1000=
_reset_hw_vf
> kworker/-86      0...2    85.381867: function:                         e1=
000_check_for_rst_vf
> kworker/-86      0...2    85.381868: function:                         e1=
000_write_posted_mbx
> kworker/-86      0...2    85.381868: function:                           =
 e1000_write_mbx_vf
> kworker/-86      0...2    85.381870: function:                           =
 e1000_check_for_ack_vf // repeats for 2000 lines

So it repeats because it waits for the bit. It waits for the interrupts.

> ...
> kworker/-86      0.N.2    86.393782: function:                         e1=
000_read_posted_mbx

Is this 2 the migrate-disable or preempt-disable counter? Because you
should get preempted based on that N.

> kworker/-86      0.N.2    86.398606: function:                      e1000=
_init_hw_vf
> kworker/-86      0.N.2    86.398606: function:                         e1=
000_rar_set_vf
> kworker/-86      0.N.2    86.398606: function:                           =
 e1000_write_posted_mbx
> irq/65-e-1287    0d..1    86.398609: function:             igb_msix_other

So the kworker leaves and immediately the interrupt gets on the CPU.

> irq/65-e-1287    0d..1    86.398609: function:                igb_rd32
> irq/65-e-1287    0d..2    86.398610: function:                igb_check_f=
or_rst
> irq/65-e-1287    0d..2    86.398610: function:                igb_check_f=
or_rst_pf
> irq/65-e-1287    0d..2    86.398610: function:                   igb_rd32
> irq/65-e-1287    0d..2    86.398611: function:                igb_check_f=
or_msg
> irq/65-e-1287    0d..2    86.398611: function:                igb_check_f=
or_msg_pf
> irq/65-e-1287    0d..2    86.398611: function:                   igb_rd32
> irq/65-e-1287    0d..2    86.398612: function:                igb_rcv_msg=
_from_vf
> irq/65-e-1287    0d..2    86.398612: function:                   igb_read=
_mbx
> irq/65-e-1287    0d..2    86.398612: function:                   igb_read=
_mbx_pf
> irq/65-e-1287    0d..2    86.398612: function:                      igb_o=
btain_mbx_lock_pf
> irq/65-e-1287    0d..2    86.398612: function:                         ig=
b_rd32
>=20
> In the above trace, observe that the ISR igb_msix_other() is only
> scheduled after e1000_write_posted_mbx() fails due to a timeout.
> The interrupt handler should run during the looping calls to
> e1000_check_for_ack_vf(), but it is not scheduled because
> preemption is disabled.

What disables preemption? On PREEMPT_RT the spin_lock() does not disable
preemption. You shouldn't spin that long. When was interrupt scheduled.
_Why_ is the interrupt delayed that long.

> Note that e1000_check_for_ack_vf() is called 2000 times before
> it finally times out.

Exactly.

> Sucessful case:
>=20
>       ip-5603    0...1  1884.710747: function:             igbvf_reset
>       ip-5603    0...2  1884.710754: function:                e1000_reset=
_hw_vf
>       ip-5603    0...2  1884.710755: function:                   e1000_ch=
eck_for_rst_vf
>       ip-5603    0...2  1884.710756: function:                   e1000_wr=
ite_posted_mbx
>       ip-5603    0...2  1884.710756: function:                      e1000=
_write_mbx_vf
>       ip-5603    0...2  1884.710758: function:                      e1000=
_check_for_ack_vf
>       ip-5603    0d.h2  1884.710760: function:             igb_msix_other
>       ip-5603    0d.h2  1884.710760: function:                igb_rd32
>       ip-5603    0d.h3  1884.710761: function:                igb_check_f=
or_rst
>       ip-5603    0d.h3  1884.710761: function:                igb_check_f=
or_rst_pf
>       ip-5603    0d.h3  1884.710761: function:                   igb_rd32
>       ip-5603    0d.h3  1884.710762: function:                igb_check_f=
or_msg
>       ip-5603    0d.h3  1884.710762: function:                igb_check_f=
or_msg_pf
>       ip-5603    0d.h3  1884.710762: function:                   igb_rd32
>       ip-5603    0d.h3  1884.710763: function:                igb_rcv_msg=
_from_vf
>       ip-5603    0d.h3  1884.710763: function:                   igb_read=
_mbx
>       ip-5603    0d.h3  1884.710763: function:                   igb_read=
_mbx_pf
>       ip-5603    0d.h3  1884.710763: function:                      igb_o=
btain_mbx_lock_pf
>       ip-5603    0d.h3  1884.710763: function:                         ig=
b_rd32
>=20
> Since we forced the interrupt context for igb_msix_other(), it now
> runs immediately while the driver checks for an acknowledgment via
> e1000_check_for_ack_vf().

Is this still RT or non-RT? I'm asking because igbvf_reset() is invoked
in ip's context and not in a worker. Also igb_msix_other() runs with a
'h' so it is not threaded.

I have a theory of my own, mind testing=20

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index d368b753a4675..6fe37b8001c36 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -912,7 +912,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	struct net_device *netdev =3D adapter->netdev;
 	int i, err =3D 0, vector =3D 0, free_vector =3D 0;
=20
-	err =3D request_irq(adapter->msix_entries[vector].vector,
+	err =3D request_threaded_irq(adapter->msix_entries[vector].vector, NULL,
 			  igb_msix_other, 0, netdev->name, adapter);
 	if (err)
 		goto err_out;

just to see if it solves the problem?

>=20
> > In the mean time:
> >=20
> > igb_msg_task_irq_safe()
> > -> vfs_raw_spin_lock_irqsave() // raw_spinlock_t
> > -> igb_vf_reset_event()
> >   -> igb_vf_reset()
> >     -> igb_set_rx_mode()
> >       -> igb_write_mc_addr_list()
> >          -> mta_list =3D kcalloc(netdev_mc_count(netdev), 6, GFP_ATOMIC=
); // kaboom?
>=20
> Perhaps the solution is to preallocate this buffer, if possible.
> Doing so would significantly simplify the patch. However, this
> would require knowing when the multicast (mc) count changes.
> I attempted to identify this but have not succeeded so far.
>=20
> >=20
> > By explicitly disabling preemption or using a raw_spinlock_t you need to
> > pay attention not to do anything that might lead to unbounded loops
> > (like iterating over many lists, polling on a bit for ages, =E2=80=A6) =
and
> > paying attention that the whole API underneath that it is not doing that
> > is allowed to.
>=20
> I unsure if I understood what you are trying to say.

The moment you start disabling preemption/ use raw_spin_lock_t you need
to start about everything underneath/ everything within this section.
While if you keep using spinlock_t you don't have to worry *that* much
and worry if *this* will break PREEMPT_RT. Not to worry whether or not
it is okay to allocate memory or call this function because it might
break RT.
OR if netdev_mc_count() returns 1 you loop once later and this costs you
1us. If it returns 100, you loop 100 times and it costs how much
additional time?

Sebastian
