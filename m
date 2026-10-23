Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739003;
	b=DvrEzV/SQwCow89OQ/bCMbsvHG3ZK2yZeznXOTvqPR5OjpaFt8XE8/iCfKXCUEjrJ37z
	 l8wVlKgBI2Imud8yxj2v4CI6QY0hw8TCUHHshQf8Zsu3UXUt+/jfQSQ14n01coyjPQjkg
	 PNylarJfebG/nR6VFkSNbNKr0pGrtY9ncV1dX6/dY7P6avOAmUgyNKitANstCTB77vPUX
	 5he9UJzwy6fddLL0cfAZI+uZJSqLP9/U04S9jn5KUVdlrUDMeIF8tgmGI0zH/HZGZ0uTD
	 mP2rjFihs9rckvJE4O4IWxeFH3b0nIutawMUiYWEDDQyGz4aYlnOPc3IFyMiJ8VH3gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739003;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
	b=IdVwOn7yt6UiPTmzadkUSKi2kHSwwjdVBsJLSeBdTz8rVZgUEGVEA/RXinOiTKdHv4qv
	 bph1cK2PlLXFXRej7dzL+kh5mtoQ2jkryyDg/7JRuy2dbT0As9c/g1jXDGhV5n6+2ZUUa
	 NPM/HVDj5JVSOfQkbLSSPH9qN8rk+oo2rzqAPA4xui+MafePicUiqrP7x8d3MzK6iullz
	 BdQTw+sr9OG2JnOrkFqTuvmJjz20q96WFmKkMATcqu9wDqx+VlVVAbTc7nuYaL5jVA/jM
	 +0UvGrwzosWYyo3dLMkTogWkLzSmNm4Mk24QUoqe4DEh4WakfditmbI387az0GlG0mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYFQ3KCV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B1606A322
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 07:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485B1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYFQ3KCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792739001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
	b=iYFQ3KCVVDSMV/qvqL4vud7v7u06U0aUKmyig4LxgqIzSul4vNHRrddhBDhxN+tKItc1X1
	ytGlz43ZmZQ2qUeBsQJvUoyiCl92M66Uhd5fPRC2bW4huWRbNceXH0w4ixCFgAxgl6pTAc
	ifId9hEhRopMyGYfGx/D1jixTFziWoY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-mX9E7ey5N4iP5lpaaMmYTQ-1; Fri,
 23 Oct 2026 03:03:17 -0400
X-MC-Unique: mX9E7ey5N4iP5lpaaMmYTQ-1
X-Mimecast-MFC-AGG-ID: mX9E7ey5N4iP5lpaaMmYTQ_1792738994
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B731E1800149;
	Fri, 23 Oct 2026 07:03:14 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BED8E180029C;
	Fri, 23 Oct 2026 07:03:09 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 1/5] ice: check the auxiliary device pointer under adev_mutex
Date: Fri, 23 Oct 2026 09:02:53 +0200
Message-ID: <20261023070258.730168-2-poros@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 10VyXF4x0jNCD0gRHCTTQPiJ7lwvE72jCm-_w1OkCQw_1792738994
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

ice_set_channels() and the mqprio path of ice_setup_tc() test
cdev->adev before taking pf->adev_mutex and dereference it afterwards.
ice_unplug_aux_dev() clears the pointer under the mutex from the
service task, from ice_prepare_for_reset() and from the devlink RoCE
and iWARP parameter handlers, none of which hold the RTNL lock, so the
pointer can go away between the test and the device_lock() call.

Take pf->adev_mutex first and test the pointer under it. Without a
device the mutex is released again and the rebuild runs unlocked as
before.

Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- new patch, the pointer test raced with ice_unplug_aux_dev()
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bf9a821c543b7f..5482a64c81c95a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3888,6 +3888,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct auxiliary_device *adev = NULL;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
@@ -3942,14 +3943,19 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EINVAL;
 	}
 
-	if (pf->cdev_info && pf->cdev_info->adev) {
+	if (pf->cdev_info) {
 		mutex_lock(&pf->adev_mutex);
-		device_lock(&pf->cdev_info->adev->dev);
-		locked = true;
-		if (pf->cdev_info->adev->dev.driver) {
-			netdev_err(dev, "Cannot change channels when RDMA is active\n");
-			ret = -EBUSY;
-			goto adev_unlock;
+		adev = pf->cdev_info->adev;
+		if (adev) {
+			device_lock(&adev->dev);
+			locked = true;
+			if (adev->dev.driver) {
+				netdev_err(dev, "Cannot change channels when RDMA is active\n");
+				ret = -EBUSY;
+				goto adev_unlock;
+			}
+		} else {
+			mutex_unlock(&pf->adev_mutex);
 		}
 	}
 
@@ -3965,7 +3971,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 adev_unlock:
 	if (locked) {
-		device_unlock(&pf->cdev_info->adev->dev);
+		device_unlock(&adev->dev);
 		mutex_unlock(&pf->adev_mutex);
 	}
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aac..984479f1e1f6d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9406,6 +9406,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	enum flow_block_binder_type binder_type;
 	struct iidc_rdma_core_dev_info *cdev;
+	struct auxiliary_device *adev = NULL;
 	struct ice_pf *pf = np->vsi->back;
 	flow_setup_cb_t *flower_handler;
 	bool locked = false;
@@ -9438,14 +9439,19 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		cdev = pf->cdev_info;
-		if (cdev && cdev->adev) {
+		if (cdev) {
 			mutex_lock(&pf->adev_mutex);
-			device_lock(&cdev->adev->dev);
-			locked = true;
-			if (cdev->adev->dev.driver) {
-				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
-				err = -EBUSY;
-				goto adev_unlock;
+			adev = cdev->adev;
+			if (adev) {
+				device_lock(&adev->dev);
+				locked = true;
+				if (adev->dev.driver) {
+					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
+					err = -EBUSY;
+					goto adev_unlock;
+				}
+			} else {
+				mutex_unlock(&pf->adev_mutex);
 			}
 		}
 
@@ -9456,7 +9462,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 
 adev_unlock:
 		if (locked) {
-			device_unlock(&cdev->adev->dev);
+			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
 		return err;
-- 
2.56.0

