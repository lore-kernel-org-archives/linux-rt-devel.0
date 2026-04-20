Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E0344021
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Apr 2026 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701460; cv=none; b=nNDBshUS5XV6DWy5zm6TWhIoBUkx3pI6oxqTM4N4Sp/TEDld66KqXi8U06HaVmxVwV06UyUp4/KL53kjekUJy0hvCElhYwSLPLmTbR6yHJCWuxoRzygajQHrVFlJz4AC0qF4dO5yWpkkEulAljt3x6tRP7adS8mKV9p4nVrnpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701460; c=relaxed/simple;
	bh=MOJKKXRCJBvIZ1NSF5DMTj9lzqj4jacPCsNx3GboOOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbXvJ/FecIXyTtj+eJPgpywjMJtJJB2NdEafVzzFLJiuJ0Iq+5v7+j4oXUv+T4l+lJ9T09V0lEDQPM30bCc0QlMdL6AukYSldtei/j1furgPdACT6sUoviZDOUgq/cNg1uVsB+H9T2675pciup2NALhhJRlLyY6WL2KMCc0Lgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQL5oNFx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQL5oNFx"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1073385a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 20 Apr 2026 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776701459; x=1777306259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxo5kEtdYHH/dmttcUyKVQWx6oJy7kEINBaa4a+z/+s=;
        b=pQL5oNFxLqeAUn+CQKYSk0DJHg3Sh1YYo/wumywT2XeAh44VQEApJUP7bd+i8q/xmL
         1c0GkdfTmUhnwv/kV+XuNUdYVpJUXpgh9/6adye6uexb7addvQI78eJP9MfeoCiYbxhM
         ZjLwx5k/lCo7diLsHeNpTJM4yVI2e7LE3g7S1nk5By5JYz3iJJdFiWVSDCuYZXpxt1U4
         FufnB0+E4yOEbUs3TZPAkYD9n7c4Ztlo+/MXBq3BH8IS2I1lBFVZzkFOmYvSqxNzyJxV
         0DyWAUAwexZzYe5PYJdVi4GOXqSaUy1vUjH/mpgnTzHj1XUujjE3zoLdHSU5i/1uYNCX
         PnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701459; x=1777306259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxo5kEtdYHH/dmttcUyKVQWx6oJy7kEINBaa4a+z/+s=;
        b=iEu8DQZvtYJWkorm+/HqX9w14TSBGZhSm2aG8+9/PsRPZhE5vxl1aaFYdtAWFtoHRH
         rbCJ+Q+wJdvWlYOxJ/7mSsOCofo7zGrCzGBzOUbO7mcNLGSHkmED1fzbqqeIfOsLluTB
         lMEdv/OWkguIpjEFO+F1f38n3UP6eP2aYMk5rhE6rGOBJA+QZ6OKiGdnHrQckOombG8X
         OhnQld/j1N7/X41fgZzqNDYzkrytVecq+74KWRTWvtLVJG1fYgmzunc8sLC8ULPNmvq/
         j3Yj2st7TethnDzWGe8an43vC02iwWLl8mwulax1KXYSeIQLsOrCoWjhHcxNKzSkfo13
         T6uQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kk+hdiFILPNTW6iiaVj9g55L1JRE0Fk+m+v2kVM1lmGE5zNJCoB/1nyFwojepJX6nzpgxqQyd7YEj/35bUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk0BZwV3rCkDt3C/h4KOkBOoYU2PslGkRU3KoPMLAallN70ke3
	yu5L4HkGEKdbVc9R1w6eWOXqmDasSMU99oMZPF7zUVPS4jDxp1xlRoR4
X-Gm-Gg: AeBDiesK5d0OcUqKaF3SO+DrFbi7ukZLvM5nof1xTN4+Ua+IIhO8RCq1v/gUg2zBJid
	mD74RVeOdvDN5NtX90ZbjaRno7oGRrsexc9fp+pZX7CQmUhTKMnawwfFeKVF1ZL5fcHglutvZ/5
	XIwXzvJyWN+y3tG9bTsIak6XSCEtdrkXTZ/RRz8Bcx8iwV/fcQc4pQ84Ikq/YrrrGoxwe2Pb9ym
	kwkZrqZ+wZiFc0PaZ1lTVVxQU5DdSVvcts9ButHlIvNEGm3te7evyvGkTNMBXHjiqP4ObF+6DwH
	Q8Qzfa9NPv5qqPHiCwlbZ8AlRgMZgVIJhNDaFjjdwUNO8IgPxl082hhgnBBib7MZhgnYB/ljigq
	/cOQ48J6gTpuKlW0BKmsuRWXK+WfG7kftmDNdgEKTk/2yMXJp7RKKIiOscnEO94KDILLcOKqBQ0
	Gug62xlxCvdNqTpVRF0fVQfpDauqhWyHjV7JJR6FchyaoCvJ4G6qol38i3EQ==
X-Received: by 2002:a05:6a20:7285:b0:39f:27ab:2454 with SMTP id adf61e73a8af0-3a08d90d557mr15520783637.49.1776701458590;
        Mon, 20 Apr 2026 09:10:58 -0700 (PDT)
Received: from lenovo.localdomain ([123.110.133.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701b1a3sm8243470a12.19.2026.04.20.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:10:58 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] wifi: ath12k: fix false positive RCU warning on PREEMPT_RT
Date: Tue, 21 Apr 2026 00:10:49 +0800
Message-ID: <20260420161049.695518-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath12k_mac_get_arvif() asserts that the caller holds an RCU read lock:

    WARN_ON(!rcu_read_lock_any_held());

On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
false positive splat whenever firmware stats events are processed,
even though the caller does hold the RCU read lock.

Root cause:

  - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
    returns !preemptible() as a proxy for "in an RCU read section".

  - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
    task can therefore be preemptible while legitimately holding an
    RCU read lock.

  - ath12k_wmi_tlv_rssi_chain_parse() holds the RCU read lock via
    guard(rcu)() before calling ath12k_mac_get_arvif(), so the
    warning is incorrect.

Typical splat seen on a WCN7850 station with periodic fw stats
processing:

  WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
    ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
  Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
  Call Trace:
   ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
   ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
   ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
   ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
   ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
   ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
   ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]

Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
debug_lockdep_rcu_enabled() and therefore compiles out entirely
when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
full lockdep-based check.

Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..a772a5b6adc9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -788,7 +788,8 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 
 	/* To use the arvif returned, caller must have held rcu read lock.
 	 */
-	WARN_ON(!rcu_read_lock_any_held());
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "RCU read lock not held");
 	arvif_iter.vdev_id = vdev_id;
 	arvif_iter.ar = ar;
 
-- 
2.53.0

