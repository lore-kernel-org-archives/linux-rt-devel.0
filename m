Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346C1B4F17
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Dec 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312613; cv=none; b=ZAGXDOJz8Ji8lFjPvP+OJ0m4cGOjAbr84qmciA803XwbhcEyzceCWcYGLVPZQIKP6ZLksRZnz6iW6JjKgB1w28LDkDs3EgoRPoTe3ttK81aw+p16kmBog9ggowW+di5rPEZMNdtqrwfe+ceAxok8hBo+W4NZuOYG/l/cU1lc0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312613; c=relaxed/simple;
	bh=4v0v9qQtQLCUVhLiNStaE4ijGcjZsY4IBnD1mAfV4Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcVYRJc6kUN3fnFpix0jY7tH/16Gp0j4cnlsVJNiV5TAtjJFB6EBy7FcIVWAinBUEKoIum0mJeQuagQ4Jyq3Q6RT/JXP0kagpfMpAA5Cvz19z7TaNTED9P1yQsgiPBJavIZtnh2WRPkwCpoMz5IcsDD8ofhxgMMlefSl+BhNJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoGeHSAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoGeHSAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nWlMtLT9W/JE0sDV4ETleqSg3lVaVJyih/3HfM+FmPw=;
	b=LoGeHSAxsLOzT0qLNWXW2OkNG51QOgeMs/sez8zaDlCSVfelImhkB7HzhLjvncNZKeRSQF
	xCHpksgZYgY8auH2Gn3JBxzhUMfgrFtVNrP/BS4clOl8KbLCFscoABzRgpbaqXweQrQpux
	5qZcZJAyCnAgG6p4YvXiAmQEdeSRkGs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-i9Q0F52zP_eqrXOK9_WW0w-1; Wed,
 04 Dec 2024 06:43:22 -0500
X-MC-Unique: i9Q0F52zP_eqrXOK9_WW0w-1
X-Mimecast-MFC-AGG-ID: i9Q0F52zP_eqrXOK9_WW0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6861955F39;
	Wed,  4 Dec 2024 11:43:19 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 318A53000197;
	Wed,  4 Dec 2024 11:43:12 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for PREEMPT_RT
Date: Wed,  4 Dec 2024 08:42:23 -0300
Message-ID: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is the second attempt at fixing the behavior of igb_msix_other()
for PREEMPT_RT. The previous attempt [1] was reverted [2] following
concerns raised by Sebastian [3].

The initial approach proposed converting vfs_lock to a raw_spinlock,
a minor change intended to make it safe. However, it became evident
that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
which is unsafe in interrupt context on PREEMPT_RT systems.

To address this, the solution involves splitting igb_msg_task()
into two parts:

    * One part invoked from the IRQ context.
    * Another part called from the threaded interrupt handler.

To accommodate this, vfs_lock has been restructured into a double
lock: a spinlock_t and a raw_spinlock_t. In the revised design:

    * igb_disable_sriov() locks both spinlocks.
    * Each part of igb_msg_task() locks the appropriate spinlock for
    its execution context.

It is worth noting that the double lock mechanism is only active under
PREEMPT_RT. For non-PREEMPT_RT builds, the additional raw_spinlock_t
field is ommited.

If the extra raw_spinlock_t field can be tolerated under
!PREEMPT_RT (even though it remains unused), we can eliminate the
need for #ifdefs and simplify the code structure.

I will be on vacation from December 7th to Christmas and will address
review comments upon my return.

If possible, I kindly request the Intel team to perform smoke tests
on both stock and realtime kernels to catch any potential issues with
this patch series.

Cheers,
Wander

[1] https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com/
[2] https://lore.kernel.org/all/20241104124050.22290-1-wander@redhat.com/
[3] https://lore.kernel.org/all/20241104110708.gFyxRFlC@linutronix.de/


Wander Lairson Costa (4):
  igb: narrow scope of vfs_lock in SR-IOV cleanup
  igb: introduce raw vfs_lock to igb_adapter
  igb: split igb_msg_task()
  igb: fix igb_msix_other() handling for PREEMPT_RT

 drivers/net/ethernet/intel/igb/igb.h      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c | 160 +++++++++++++++++++---
 2 files changed, 148 insertions(+), 16 deletions(-)

-- 
2.47.0

