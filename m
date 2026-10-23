Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739010;
	b=xnoKVEh8pajiXP5ecNwWoDR2Dgpobz4dbw24gR/TUMDQzX+316C/pMddYlUDof61qy0Y
	 xGUyGr0Kka+Ac/TwAK/dAAT8iZtresDWAygpu5JXD4SaOHM+znqqx6BhxNi3RB0iHx/Kz
	 WRiBqZAGLyrs8g1EvIsW9zICcRTxzNQxqew1wP4kdphoCSSIFn/nXe7tTcHAhjPiMexmX
	 kVV4FpFpxF/IZBkhWdl89q3ewkG30wX37Rl8DminMKIj3AmDejPsvvbKIYVQ9Ga4oN3sB
	 3vRr94TMsBJra12P4nmgMu3JHZkGhQEkFCGMDILZQ+3MwztA7PiXLD5OTSrx6YtH1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739010;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
	b=BteLKr0XlvCscA5YNkQIO7VJXFsenNzKBVRFJfbdcQIc/D8piW/qMbe3mA+2a27Zo8VG
	 MiEyr/76Wr3griSv+g03BrDVffY80lsxguL1sBsHE3HLAS8LGgoAbr+SQJVMd5Dlkil0Y
	 /adXU7F8bziaLb1oynqmqoqpSd9+3sE6myBPXQmDzgkg1KIETxNX+bhbC03B0TPDf2Or7
	 N1+57HYi5la8zFBif8Imm8a/T4GJggmGEtFEbnZ2i8ZtUXYWpO1nAIY6E7zl95Ufgc9vP
	 SqlrUFYVKfEVuYXt4Qp3M49QIrXz4Eu3TFFiWRqW+NjdlQIMQjISX8FUGGurN0qU4Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aR5w9egi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655E606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 07:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6655E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aR5w9egi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792739009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
	b=aR5w9egigaPx1GiRlGzqLnzGIt5vlwBF+rKbH3rBLIP/1W11xjyf1rBCJG4zvJqpv+fYKw
	dmdVPweE7UgIegIMhr6qqo2QM9t1ydAW8Gkg9xwpNRdb787zUZTAtkEQK6AdpTixxDOUB5
	W3FSsljsZ5jG4UXKOHCDWIoY4eKAtPE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-6C2F93JlOfGx6fuJEDqLpw-1; Fri,
 23 Oct 2026 03:03:22 -0400
X-MC-Unique: 6C2F93JlOfGx6fuJEDqLpw-1
X-Mimecast-MFC-AGG-ID: 6C2F93JlOfGx6fuJEDqLpw_1792739000
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3007A18005BA;
	Fri, 23 Oct 2026 07:03:20 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 247CD180029C;
	Fri, 23 Oct 2026 07:03:14 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 2/5] ice: take tc_mutex before the auxiliary device locks in ndo_setup_tc
Date: Fri, 23 Oct 2026 09:02:54 +0200
Message-ID: <20261023070258.730168-3-poros@redhat.com>
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
X-Mimecast-MFC-PROC-ID: V4Oh1Wy8sm6uN4X1Jf6GONXsEA3T7PnxbxH801RyJ5c_1792739000
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The mqprio path of ice_setup_tc() takes pf->adev_mutex and the auxiliary
device lock first and pf->tc_mutex after them. The dcbnl handlers take
pf->tc_mutex first and reach pf->adev_mutex through ice_pf_dcb_cfg() and
ice_send_event_to_aux(). Both run with the RTNL lock held, so the two
orders do not deadlock against each other, but they form a circular
dependency for lockdep, and the DCB reconfiguration is about to hold
pf->adev_mutex for longer.

Take pf->tc_mutex first, which is the order the dcbnl side has used
since pf->adev_mutex was introduced.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- new patch, ice_setup_tc() took pf->adev_mutex before pf->tc_mutex
  while the dcbnl handlers take them the other way round
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 984479f1e1f6d9..8693ca285d5f1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9438,6 +9438,8 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			return -EOPNOTSUPP;
 		}
 
+		mutex_lock(&pf->tc_mutex);
+
 		cdev = pf->cdev_info;
 		if (cdev) {
 			mutex_lock(&pf->adev_mutex);
@@ -9456,15 +9458,14 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		/* setup traffic classifier for receive side */
-		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
-		mutex_unlock(&pf->tc_mutex);
 
 adev_unlock:
 		if (locked) {
 			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
+		mutex_unlock(&pf->tc_mutex);
 		return err;
 	case TC_SETUP_QDISC_ETF:
 		return ice_offload_txtime(netdev, type_data);
-- 
2.56.0

