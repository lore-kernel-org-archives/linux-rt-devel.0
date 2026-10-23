Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739024;
	b=A4Ez2DlpVEYFZCaweQqd+HlGWaiY1UW79lrP/nEkq7COh0v282oXPMdm6fwEYcGX7Y5l
	 SgCWOWYouStgdyJ6R70Z+qt/Q+peHrzA/4z4LVWgVi9S7AGevNSb8pjp4rsouSmJdXZkQ
	 3jdeHdjjaU8n0s0Mq19wffMZRtA9uknIcn0t/FutWYs9YALK1sRGPyJOjtaj13zZgS3ev
	 +eVlaWMBfax3Hi7uGXtY7lSduTgt6n3/GpqSk+i13cXNcNYb2FnPTn6/cJpEI8nTHDqyM
	 0sQjzjDox84xrxzFjK6HnMKeg01mYL+gA8r3qpb0nq6i3oyHaoG3EQPJ6HBzoTfE5Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739024;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	b=X8PQz6JJv1SqOvfqKU40v9/jwedq6/3aCaOdnzZLA4BhIoF0INV2del8RE4XZviyv9Aq
	 LO4Lya/pfXeWHHkvyr+H0oDqjt6/nuDgUhAw/v/CZX1snrpVY2Ks+YdCylsx9lnjAYH4o
	 WIH/Or+sCEjDVdVd4FQPUSeNfzkFiUAIZhjUoK7QmjDZp/Vy2j8dlCzg0NGmuW2/HO6h3
	 1AZHP/fTY9mwAC+Br7caZMBxMTGsc5gpWd084htWfIvvS8EmCBjhgeVV03h7uPI+BegO+
	 AfUQ+a+dOgONhuuxMxfSPhopUDDImpVEh5mhZ7krsnYmI9v0/kZqaQiFNwY5eNl9ZaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGQLpkuv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241A60A3824
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 07:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5241A60A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGQLpkuv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792739023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	b=JGQLpkuvdTQrnEl8ZlNFRI4EKmm+z2ivm1+IRqQjt8ZTDiJFLEv7XlNgFz6EG3Mw23NL+j
	b/Vc0FfYlHcwOFUnap6rVUJ46cJbgJk4ZtjNofzecSUBzN7pnsGQ1b/SxzE3d1Bi0QxKaN
	h9ZjWiQp9VlpnKxrtOTDEvuccDPWP8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-6dwtmr-BPEaaGiperbAeJA-1; Fri,
 23 Oct 2026 03:03:39 -0400
X-MC-Unique: 6dwtmr-BPEaaGiperbAeJA-1
X-Mimecast-MFC-AGG-ID: 6dwtmr-BPEaaGiperbAeJA_1792739017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1631A1956053;
	Fri, 23 Oct 2026 07:03:37 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4BB11800347;
	Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rafal Rogalski <rafalx.rogalski@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 5/5] ice: do not block on the aux device lock in ndo_setup_tc
Date: Fri, 23 Oct 2026 09:02:57 +0200
Message-ID: <20261023070258.730168-6-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: J2Ft_vaJux1YQGVPlpqA-GP2XCyKFCUiy-mtJg4KfxY_1792739017
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
runs with the RTNL lock held. This closes the same cycle against the
RDMA auxiliary probe as the two preceding patches.

Use device_trylock() and report the device as busy when it fails. When
the qdisc is added, userspace gets -EBUSY and can retry. When it is
deleted, mqprio_disable_offload() ignores the return value, so the
hardware traffic classes and the channel VSIs stay in place until a
later qdisc teardown gets through, the same as the existing -EBUSY for
a bound RDMA driver. The message is a netdev_warn() because of that
second case, nothing else reports it.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- rebased on the new patches 1 and 2
- netdev_warn() instead of netdev_dbg(), the qdisc teardown cannot
  retry and ignores the return value

v1: https://lore.kernel.org/all/20261019065301.3983537-4-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9de375f5c4deb5..7eb653a7ebacd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9451,7 +9451,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			mutex_lock(&pf->adev_mutex);
 			adev = cdev->adev;
 			if (adev) {
-				device_lock(&adev->dev);
+				if (!device_trylock(&adev->dev)) {
+					mutex_unlock(&pf->adev_mutex);
+					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not changed\n");
+					err = -EBUSY;
+					goto tc_unlock;
+				}
 				locked = true;
 				if (adev->dev.driver) {
 					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
@@ -9471,6 +9476,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
+tc_unlock:
 		mutex_unlock(&pf->tc_mutex);
 		return err;
 	case TC_SETUP_QDISC_ETF:
-- 
2.56.0

