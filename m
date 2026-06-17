Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771239F165
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688071; cv=none; b=ezoQHe4WiISj1MoaamQZRVmFsSbOXpq75uaQtWIxOWRPR0UgYGZ0eOTnL+fejsxq7OdZfsdBFbYZWMQ8l6PVR7m+fF2VwrU+9hOKIE6gymIIMs2bPsxxvTgqZGgwBOc/l0jODkFOcIx0GSGBfPc2EIrLAANnHJQtLb52ilELSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688071; c=relaxed/simple;
	bh=LIRBeWDfQgjonIba4QN4dOgeak6y/2hYSMMFE3xZmT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jagjWO/S/yulu8K4O2liA3Bi7DQn8rMswVKEe2mLXNrwd+MXcTcCa/aHg8CCAJC53DZDVDykcWIeNAX+CTmLPSAk0EP0mCNNOkcepzWoz5YHEoaHZ0gJJDGQ74P0Ezsx04R+rQ9x9najbaYYeW5oYTBzAb1UblcIbihnVsB+35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=PQw8KFPk; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="PQw8KFPk"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8Zbc71267723;
	Wed, 17 Jun 2026 09:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=kNaYejiDj
	tQFZOco6tnQcxUnFfuW0acllcPY6JfQeR4=; b=PQw8KFPkVgFNLeQNGoLwAd4MZ
	Ps0nECbLpCEzxRTh6vCYLFIVcyUL4wzj1QcOHGBSkvTrZqVQk2Yh6YxXvEjmWVgl
	7vGdjTZSkpj8qQWgkFqhYtdDAPT8+FZy/YgUccwGCiFUiSGW4btIMkTTdB2Jp5KK
	tfuUhL07CSg77qyZrAF89XgChCigX1oSifIGbP287P3dIlm/cfsyjOJkpDrVEPcY
	kV/0tIng3t4/MyAvsHxMgj4FNbEheAeuRneZ7U0AwkQhpHudfofPdXIu4p73kpVa
	hAf7Wi/HgVLR7zYao20uhcenaXI3lKrxITBRWUHIw8nYvij7VrOS7591g9RxA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc0qxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Jun 2026 09:20:32 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 17 Jun 2026 02:20:31 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 17 Jun 2026 02:20:28 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <yun.zhou@windriver.com>
Subject: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
Date: Wed, 17 Jun 2026 17:20:28 +0800
Message-ID: <20260617092028.1722407-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4NyBTYWx0ZWRfX1nQ7h/yRsUnF
 0kM8dV4qZNgnHJR46V3LTBdkiIPQNjuq0GNU4qDz3IwCE0QOegWNhHzcIrQqIkMTZ0KjjNC2wbg
 rSwctcx9i7Jl7GAilv/sGHv99WhDw7nKTSsxB23xDDnT1uqfzQph
X-Proofpoint-GUID: B1XrctJ9f-Abn6mGHIz_d4m0IxersnYG
X-Proofpoint-ORIG-GUID: B1XrctJ9f-Abn6mGHIz_d4m0IxersnYG
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a3266e0 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=H1i4495hyjeC5Vi1NPAA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4NyBTYWx0ZWRfX4W+uFoCoo59K
 h+gEFL2ayfMGMQoMxjnpvlSwh27ZnRuhnEt1MESz/s8LdXFvQgOgYW29WLcD0xBeb7oH/ai50kE
 vsrFv8LB2B+MIM7jxex/TlHjtTPBQABieLyOiP68JC3x1y/Crm6vQiUCZPV4yWnFTAdV6KfazzR
 P9NwHD4InSBMm52L/MyDEFlFeUAod/7V7j7fmkE/HPuflN0XCpSHV21Z9I6yFyzGPUslNJ8fq65
 y9UFNwkxYqORF6moYAwyvfPvfKf4CjmHCxxH0Iyv8ZNcuHMkpLeodCam/gdl0GOUNo+5rPE/eV1
 82nfXbTeFqPbuVzUqSt2nmgoPcFwSK4/7ImTUYdJzuA+TuInx83hM5/lPwz3tsV8B9rJHSAD4vP
 GKZtI1/lWotYZxqI5xWkIhPVIexh1gxd5lLIs7kZrWCtNKK53qT5tzTCeY5GCGRluM/SuA+VzFj
 EB50l1kLRbIgcJ5kXXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170087

On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
network traffic, the IRQ can enter suspend with desc->depth == 1
(masked by the oneshot mechanism between handler invocations).

During suspend, the kernel increments depth to 2 and masks the
interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
due to IRQCHIP_MASK_ON_SUSPEND). On resume, depth is decremented
back to 1, but since it does not reach 0, the unmask is never
called. The MPIC CPU routing remains cleared, permanently disabling
interrupt delivery.

Fix by freeing the IRQ in suspend and re-requesting it in resume.
This ensures a clean IRQ state (depth=0, proper hardware routing)
on every resume cycle, regardless of the pre-suspend depth. This
follows the approach used by other drivers (e.g. igb).

Fixes: 9768b45ceb0b ("net: mvneta: support suspend and resume")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v2:
  - Move request_irq before cpuhp registration in resume (matching
    mvneta_open ordering) so that failure does not leave cpuhp
    callbacks registered on a non-functional device.
  - On request_irq failure, call netif_device_detach() to prevent
    further traffic on the dead interface.

 drivers/net/ethernet/marvell/mvneta.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index b4a845f04c05..02ea867d07a3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5826,6 +5826,20 @@ static int mvneta_suspend(struct device *device)
 	mvneta_stop_dev(pp);
 	rtnl_unlock();
 
+	/* Release IRQ to avoid stale MPIC mask state on resume.
+	 * On PREEMPT_RT, forced-threaded oneshot IRQs may leave the
+	 * interrupt masked (depth>0) at suspend time. This prevents
+	 * resume_device_irqs() from restoring the MPIC CPU routing,
+	 * permanently disabling the interrupt. Re-requesting the IRQ
+	 * on resume guarantees a clean state.
+	 */
+	if (pp->neta_armada3700)
+		free_irq(dev->irq, pp);
+	else {
+		on_each_cpu(mvneta_percpu_disable, pp, true);
+		free_percpu_irq(dev->irq, pp->ports);
+	}
+
 	for (queue = 0; queue < rxq_number; queue++) {
 		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
 
@@ -5892,6 +5906,21 @@ static int mvneta_resume(struct device *device)
 		mvneta_txq_hw_init(pp, txq);
 	}
 
+	/* Re-request IRQ (see comment in mvneta_suspend) */
+	if (pp->neta_armada3700) {
+		err = request_irq(dev->irq, mvneta_isr, 0, dev->name, pp);
+	} else {
+		err = request_percpu_irq(dev->irq, mvneta_percpu_isr,
+					dev->name, pp->ports);
+		if (!err)
+			on_each_cpu(mvneta_percpu_enable, pp, true);
+	}
+	if (err) {
+		netdev_err(dev, "cannot request irq %d\n", dev->irq);
+		netif_device_detach(dev);
+		return err;
+	}
+
 	if (!pp->neta_armada3700) {
 		spin_lock(&pp->lock);
 		pp->is_stopped = false;
-- 
2.43.0

