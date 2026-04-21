Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B802E719C
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792380; cv=none; b=AYtThGyLUoIhd/evBcw2fPcIbuGxw5znZ3VMG3Aqr6+ozZtChFctmg6HuyDyqEXbaf2MrP4TcZvGAF18orAXDJDgpljK7iV8raJtME+PnvLizfx4JCafjXyWXkdnaPPHbPZwEvRIcpzlc8xYAVeKEAzAnbRSWG1xKTFSBkESZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792380; c=relaxed/simple;
	bh=army6csuzlkfmCzKW9Q6UiVBt0h02XrDzPZdS88qN00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPOw5rsLBhUN93WizHd96OZR61kteuW8iJ9A30UM5Rkk9jVxZ+ir3ErdaRnhah3xNLVwQlaMfr9tMGy1KTAbUfU+vOQQidORCibfo4AVVYX7BiXCLHc0g1KLXWvVAz07MX5tExRsUYhJaWh+59YoKOyOdVJAhCps1fGdJTWkmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsF6pc9o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsF6pc9o"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so20556535ad.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792378; x=1777397178; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu5+POdFqqclIWWOEr3Sv9HNAu+bDuUYEserSDIYQ6I=;
        b=NsF6pc9ozg3tny0ukzlVkAFJ1wtu3A/wakfwl5a3AJNrRO5+KwtLh6qtbQRvtFHhBA
         ue2Ls0z3s9SiFWaTSTpdBLjA5y1bwhROL184bcOpZX6KdBFFRfD/DWsbXymT+vKuIcsB
         Q7NrwziVHSY4fXTdHFGa5JUTgbJI5u9h2W7nSb/OAk8enVARjz0DC24MN3OFfQy5rUR2
         CdZgztfzNygD78jJoKci1PaZeFnOT6J1z7T95UjZND4zZ88LOg4M1EZGQhxpLIatW3MO
         tM9l3cJexNMFRGOBQddsAlC/H5qmHXRBVFXSzV9ueFbkOOjwdC5wTXpW/vnsM+QHkIox
         GUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792378; x=1777397178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu5+POdFqqclIWWOEr3Sv9HNAu+bDuUYEserSDIYQ6I=;
        b=Y+pUz8WWr4j8F5oh/KVr32w7sBe9l3a7NQO8rkW0DAqzj5reU2AW6V9U3sqi15nhw+
         yRa1FaFxRaq+kPinzlHDilqpqR2ZX9CSlc2E7KeTxrdZnG0RkCprLGuVQQrBzl57Nk+I
         ZsxyyrOSs6z2f/HG2kJ1dsEAbANcIQ8nCYOXRxXZJ6v6TAiodYXKb9oOnEhaEth7qSew
         /UJpvknLV533Nk+NbbU8htoJnjoCzyRaJV8ZdtB5nPYA1iJ9dILMbziyMjkiiZRRaNvy
         ezzeiXuvroJnco2aDMDxb6jgaSOA7/cwEvADQXUHltdwkhLTQjqc4vxPp1WNOGdJKEkK
         CUyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WSGLb3Va+p1RJQVcZZ1wx/9VI0qf4PS4lA4eT+uwQwo6z4vLH90AGb+SvDk5peu309sb9HaqKHjSrCdZiwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxzO66YjmfWy0k+Ayby3Ohw0aYrrWs7VL91qykI5hRr+W8wevn
	mvxyGAPDWgyUuvjIGg813f4IPymS3iyS6OSUyzCCtJGM8BDY6+XcrI9/
X-Gm-Gg: AeBDievDKV4Aczeojqej4Bs2sPbKEJ+JIkTXAQho0ztR6VwEOy1QPujt2Gbys598Fhs
	icHvrGOMCUEnWer7/kJdKAnm/RmWz+0CKgM2liYotmUbUf0YrBmox4loCKkyfDu52X/SLd8XUJk
	ziw9a31iZ+EwInPagZiiim4pEpxvCUEKzhfGrQtKPplgOeX2vOtBQG4xxs9NPMqep+NwpubsHVk
	VEeQjWxBXLt73YUiBWw+1JiwzjqfCXsMlmZApuU5UU1Dhw0+hBz4qV6fRZpWOk3xA+CC7eT3Ci8
	/JHOa9nXeLiP6grtGEFMq7S4cNTQLSwKDHbL+BtJnCcvC+Dy6c2j0vVa8nGd4ZWvBjTvfQokwQI
	sWrbfIFfV7jJaBY0j71i01B9s8s/rbmHiO+tAy0pX///v4pwpQhTLBI02Z1SqgOwDkWJU8cq/qN
	sR8PIiKoYAHjQ6MNGv1hoP5xAkCVnWTYNErVlYTfrYCZhDDYg=
X-Received: by 2002:a17:902:db0d:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2b5f9f52879mr182995625ad.38.1776792378433;
        Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
Received: from lenovo.localdomain ([123.110.133.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm144897015ad.37.2026.04.21.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
Date: Wed, 22 Apr 2026 01:25:00 +0800
Message-ID: <20260421172500.1050754-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two functions in ath12k assert that the caller holds an RCU read lock:
ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:

    WARN_ON(!rcu_read_lock_any_held());

On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
false positive splat whenever these functions are invoked from paths
that do hold the RCU read lock (e.g. firmware stats processing or
mac80211 interface iteration).

Root cause:

  - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
    returns !preemptible() as a proxy for "in an RCU read section".

  - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
    task can therefore be preemptible while legitimately holding an
    RCU read lock.

  - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
    and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
    read lock, so these warnings are incorrect.

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
Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
Changes in v2:
  - Also fix the same WARN_ON() in ath12k_p2p_noa_update_vdev_iter()
    (suggested by Baochen Qiang)
  - Update commit message to cover both call sites

Link to v1: https://lore.kernel.org/ath12k/20260420161049.695518-1-asas1asas200@gmail.com/

 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 drivers/net/wireless/ath/ath12k/p2p.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 59589748f1a8..caa92612372b 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -123,7 +123,8 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 	struct ath12k_p2p_noa_arg *arg = data;
 	struct ath12k_link_vif *arvif;
 
-	WARN_ON(!rcu_read_lock_any_held());
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "RCU read lock not held");
 	arvif = &ahvif->deflink;
 	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
-- 
2.53.0

