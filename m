Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198C25E45A
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Apr 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024297; cv=none; b=Kh29gWwnkpNrxTb2QMcTbuXxJgZv+Qs1WnzHfJGaXwPJxHO3KuElaothP77BadGVwalKfYXLkL/JTrELsZbTqF9a+pvFk2iy145ziSmyeFRP31FpsvxR/wXqe0wEa7MLsbKFH5fRNJ3VoQI7WWLEUiONZtNLhUAVslj2Xft6Uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024297; c=relaxed/simple;
	bh=cxBJ6gd/C719nlDJ5KFeq2v+OVuoUb45wdS+oTB+2Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFkPSSfTrR/g2glMu9cMiT/vTjRr/nnuOss2Zsn/hNRZJ+3OgDVv3c9jyXfB6p7dxRw0E1xfPR2wlL2gH/orhM/Kv6ooipFoF95yTAak1lRxfmfwG4uZUstLSMXAzmdXVVQ5qHDBj0Te3cd91paDf+3g9UlkeJcGh7KnlZTdlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8nrOYSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQ6W2tHY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8nrOYSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQ6W2tHY"
Date: Wed, 30 Apr 2025 16:44:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746024293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TdjNj/Z8hXHrzanMpLobxS/s3TyVCieP9g/NQcu6SxU=;
	b=Q8nrOYSPZgK4XGpPUUixqrGEZcFMaKv6gXR3wHftdT1gMKvqmjGa4YtWZufX1eZfA+oPmB
	kjddxznKKgoZDPHcRWq9dvJHDdkWwni+5of2XNvBFzUHhGwUojiVyuR72+qUHLVw27D3pD
	7Txu1E9d/uiKF+9OvLaTeJY3VVQoix1zHTYb8hXWyvSRm5fYfqrJkRP5HrO5nficFLVSB7
	VuLXh26yBsD0UQiMI0iibwguAs/mFtsV+qG0IqXZRHEDQH9IMbfq6+5NpfVL/No2kjf4TV
	rszzwn3zn6rIYMJ47rJ6WI7mdJhm3H8JFGlAErIt/v87gMq5A1ob/klKtEQ06Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746024293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TdjNj/Z8hXHrzanMpLobxS/s3TyVCieP9g/NQcu6SxU=;
	b=vQ6W2tHYdmi9lJ33GkLDCDLIrlGCYSQsuFAP7r3iClEzKyo0EfM2PbSBh+lPhFW52brSaL
	VSXTfeBglICqWKAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] igb: Request igb_msix_other as a threaded interrupt handler
Message-ID: <20250430144452.8zcAZc29@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Wander reported that performing a SR-IOV setup on PREEMPT_RT can fail/
timeout.
The reason is that during the setup the VF device performs a reset
(igbvf_reset()) and polls for an ACK (e1000_reset_hw_vf() ->
e1000_check_for_ack_vf()) with disabled bottom halves. For the ACK to
complete it is required for the igb_msix_other() interrupt handler to
run.
The interrupt handler is forced-threaded on PREEMPT_RT and therefore
delayed until after bottom halves are enabled again. This happens only
after e1000_reset_hw_vf() times out. This scenario requires that the
interrupt handler and the reset handler run on the same CPU.
This scenario is not limited to PREEMPT_RT but can also happen without
PREEMPT_RT if the interrupts are forced threaded via `threadirqs'.
Setups without forced threaded interrupts are not affected.

The interrupt handler (igb_msix_other()) does not require bottom halves
to be disabled. It does not call into the network stack which would
mandate it. Requesting the handler explicit as a threaded interrupt will
not disable bottom halves prior invocation of the handler thus avoiding
the scenario.

Request igb_msix_other as a threaded interrupt handler.

Reported-by: Wander Lairson Costa <wander@redhat.com>
Closes: https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I've been sitting on this one for a while. While this avoids the timeout
on a PREEMPT_RT setup, the !PREEMPT_RT + threadirqs setup remains
affected. The difference is that PREEMPT_RT allows a context switch
within a local_bh_disable() section while !PREEMPT_RT does not.

Allowing e1000_reset_hw_vf() to run/ wait/ poll without
e1000_hw::mbx_lock, which disable BH, should fix both setups.

 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c646c71915f03..0827e8dcd9de7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -912,8 +912,8 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i, err = 0, vector = 0, free_vector = 0;
 
-	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, 0, netdev->name, adapter);
+	err = request_threaded_irq(adapter->msix_entries[vector].vector,
+				   igb_msix_other, 0, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
-- 
2.49.0

