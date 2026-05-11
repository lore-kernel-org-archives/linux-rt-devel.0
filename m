Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8D381AEA;
	Mon, 11 May 2026 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476279; cv=none; b=GbM/AJPwUU3GK6jqBqd296qWIkRRv03kZaUA8TtX0iFLnFGTJKkt7LUkvFU+akB3wfmGOEJPqfsUy/TWNLTlYC6+jVtOSHQ0xRlxLYT54YXWPtbXW0aXOvJQImVBSa1g26lbHAq5sxd9wEeVEMrSMiCD8dakZnVvwjbbwqV35iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476279; c=relaxed/simple;
	bh=ZUXKow7Jh5NPcRT1AHjWwA153dfWBPqEk93hx0bvVtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcPjT8PyqAKdceklKABn/iNMNUDB+4nTlij9oPwtG0+ZQdhJYKF6Yvt1pfzh3PFZgmMCusvbVmsVlqOxE8PZ70O6b7HqM1Gph6achcs9TU0rF8P3Knwscb9Xq5/w7O5tS9v5eW2sV6VA/o1a6SBjQsUSY0WYdBSqB7ryBOWiN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4ewWEfd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4ewWEfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2072C2BCFF;
	Mon, 11 May 2026 05:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476279;
	bh=ZUXKow7Jh5NPcRT1AHjWwA153dfWBPqEk93hx0bvVtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C4ewWEfdMzj7YhueADle0xhRNmj6mP3USLoV+FslqZKtgENOHnOxzi/XHH7vrr2Gb
	 yhX/ThWzqNFh35OPJQ55XFbCFg1gQbXU1768rI+T0U5ighW7iHnNWWQVX12iPl6hZG
	 RXLn5yKAEVR/OPTVHHvrNV3Ko5wn3EqlW5EgmpA7kyWEgZjhTSe1yntcS414e4mJTs
	 KNOjwRDdzBbhYLPSp8o0YOXED9gnw42eJ9WJkc0VHiXFxuBPF0/Tj5n6OpMNntnvJy
	 K4H0+ykPyGCg7Fbo5glzzQPtrDKFFx0VvqlqgdyAevl4gn+d4thMDpl/up3Eszp6SC
	 JCic/geCTluQQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:11 -0700
Subject: [PATCH RFC v4 15/18] riscv_cbqri: resctrl: Add mbm_total_bytes
 bandwidth monitoring
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-15-eb53831ef683@kernel.org>
References: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
In-Reply-To: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8413; i=fustini@kernel.org;
 h=from:subject:message-id; bh=ZUXKow7Jh5NPcRT1AHjWwA153dfWBPqEk93hx0bvVtQ=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxpryeEXshqiWj/fO5Ha3fDxTmT8mpUbGevUAr69LmN
 +xXLWX8OkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATSfVjZJglv97j0X41iUUh
 ioLFb+4FsHxcECHhdvKj6DmlKXz5YocZGd7pRSX1M4edTNnpOdtK/lv1timVq37ovmcI6vmVfbN
 EhgsA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Expose CBQRI bandwidth controller's combined read+write counter as
the L3 mbm_total_bytes event. A software accumulator keeps the
64-bit byte total monotonic across the 62-bit hardware counter wrap.

mbm_local_bytes is not supported because the CBQRI spec has no way
to distinguish total versus local. Bandwidth monitoring is disabled
on platforms with more than one CBQRI bandwidth controller, since
the counter could not accurately attribute traffic across L3 domains.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 154 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 150 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index 71ee8e610757..ccd48cac7ccd 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -30,6 +30,13 @@ struct cbqri_resctrl_res {
 struct cbqri_resctrl_dom {
 	struct rdt_ctrl_domain  resctrl_ctrl_dom;
 	struct cbqri_controller *hw_ctrl;
+	/*
+	 * For an L3 capacity controller paired with a bandwidth controller
+	 * of matching topology, paired_bc caches that BC so mbm_total_bytes
+	 * reads / resets don't have to walk cbqri_controllers on every hit.
+	 * NULL for non-L3 domains and L3s without a paired BC.
+	 */
+	struct cbqri_controller *paired_bc;
 };
 
 static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
@@ -38,7 +45,7 @@ static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
  * Per-event controller table. Only events CBQRI can back occupy a
  * slot, so other events do not bloat the array.
  */
-#define CBQRI_MAX_EVENT QOS_L3_OCCUP_EVENT_ID
+#define CBQRI_MAX_EVENT QOS_L3_MBM_TOTAL_EVENT_ID
 static struct cbqri_controller *cbqri_resctrl_counters[CBQRI_MAX_EVENT + 1];
 
 /*
@@ -239,6 +246,36 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d
 		mutex_unlock(&ctrl->lock);
 		return;
 
+	case QOS_L3_MBM_TOTAL_EVENT_ID: {
+		struct cbqri_controller *bc;
+
+		cd = cbqri_find_ctrl_domain(&r->ctrl_domains, d->hdr.id);
+		if (!cd)
+			return;
+		hw_dom = container_of(cd, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		bc = hw_dom->paired_bc;
+		if (!bc)
+			return;
+		if (WARN_ON_ONCE(!bc->mbm_total_states))
+			return;
+		if (rmid >= bc->mcid_count)
+			return;
+
+		mutex_lock(&bc->lock);
+		/*
+		 * CONFIG_EVENT both resets and re-arms. Skip the accumulator
+		 * memset on failure. A stale hardware counter X with
+		 * prev_ctr=0 would inject overflow(0, X) on the next read.
+		 */
+		if (!cbqri_mon_op(bc, CBQRI_BC_MON_CTL_OFF,
+				  CBQRI_BC_MON_CTL_OP_CONFIG_EVENT, rmid,
+				  CBQRI_BC_EVT_ID_TOTAL_READ_WRITE, NULL))
+			memset(&bc->mbm_total_states[rmid], 0,
+			       sizeof(*bc->mbm_total_states));
+		mutex_unlock(&bc->lock);
+		return;
+	}
+
 	default:
 		return;
 	}
@@ -249,8 +286,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domai
 	int i;
 
 	/* Bound by max_rmid (system-wide minimum mcid_count). */
-	for (i = 0; i < max_rmid; i++)
+	for (i = 0; i < max_rmid; i++) {
 		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_OCCUP_EVENT_ID);
+		/* mbm_total_bytes reset is a no-op for L3s without a paired BC. */
+		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_MBM_TOTAL_EVENT_ID);
+	}
 }
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
@@ -308,6 +348,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 		mutex_unlock(&ctrl->lock);
 		return err;
 
+	case QOS_L3_MBM_TOTAL_EVENT_ID: {
+		struct cbqri_controller *bc;
+
+		/*
+		 * The L3 monitoring domain's id is the L3 cache id. The
+		 * matching ctrl domain's hw_dom->paired_bc was cached at
+		 * add time to avoid walking cbqri_controllers on every read.
+		 */
+		d = cbqri_find_ctrl_domain(&r->ctrl_domains, hdr->id);
+		if (!d)
+			return -ENOENT;
+		hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		bc = hw_dom->paired_bc;
+		if (!bc)
+			return -ENOENT;
+		if (WARN_ON_ONCE(!bc->mbm_total_states))
+			return -EIO;
+		if (rmid >= bc->mcid_count)
+			return -ERANGE;
+
+		mutex_lock(&bc->lock);
+		/* Pass EVT_ID explicitly. Same reason as the CC path above. */
+		err = cbqri_mon_op(bc, CBQRI_BC_MON_CTL_OFF,
+				   CBQRI_BC_MON_CTL_OP_READ_COUNTER, rmid,
+				   CBQRI_BC_EVT_ID_TOTAL_READ_WRITE, NULL);
+		if (err)
+			goto out_bc;
+
+		ctr_val = ioread64(bc->base + CBQRI_BC_MON_CTR_VAL_OFF);
+
+		if (ctr_val & CBQRI_BC_MON_CTR_VAL_INVALID) {
+			/*
+			 * Hardware marked the counter invalid (CBQRI 4.3:
+			 * controller could not establish an accurate count).
+			 * Return the last good total and leave prev_ctr so
+			 * the next valid sample resumes from there.
+			 */
+			*val = bc->mbm_total_states[rmid].chunks;
+		} else if (ctr_val & CBQRI_BC_MON_CTR_VAL_OVF) {
+			/*
+			 * CBQRI 4.3: OVF is sticky until next CONFIG_EVENT.
+			 * cbqri_bc_mon_overflow() can recover at most one
+			 * wrap. With OVF set the count is unknown, so re-arm
+			 * and re-anchor prev_ctr=0, losing one wrap-period.
+			 */
+			struct cbqri_bc_mon_state *s = &bc->mbm_total_states[rmid];
+
+			pr_warn_ratelimited("BC@%pa MCID %u: CTR overflow, bandwidth count loses ~one wrap-period; consider a wider CTR or a faster poll cadence\n",
+					    &bc->addr, rmid);
+			err = cbqri_mon_op(bc, CBQRI_BC_MON_CTL_OFF,
+					   CBQRI_BC_MON_CTL_OP_CONFIG_EVENT, rmid,
+					   CBQRI_BC_EVT_ID_TOTAL_READ_WRITE, NULL);
+			if (err)
+				goto out_bc;
+
+			s->prev_ctr = 0;
+			*val = s->chunks;
+		} else {
+			struct cbqri_bc_mon_state *s = &bc->mbm_total_states[rmid];
+			u64 cur = ctr_val & CBQRI_BC_MON_CTR_VAL_CTR_MASK;
+
+			s->chunks  += cbqri_bc_mon_overflow(s->prev_ctr, cur);
+			s->prev_ctr = cur;
+			*val        = s->chunks;
+		}
+out_bc:
+		mutex_unlock(&bc->lock);
+		return err;
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -730,6 +840,16 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 			res->mon.num_rmid = ctrl->mcid_count;
 			resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID,
 						 false, 0, NULL);
+
+			/*
+			 * Expose BC bandwidth monitoring as the L3's
+			 * mbm_total_bytes when a BC shares topology with this
+			 * L3 (MPAM "MB on L3" mapping).
+			 */
+			if (cbqri_resctrl_counters[QOS_L3_MBM_TOTAL_EVENT_ID])
+				resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID,
+							 false, 0, NULL);
+
 			res->mon_capable = true;
 		}
 		break;
@@ -818,8 +938,8 @@ static int cbqri_resctrl_pick_bw_alloc(void)
 }
 
 /*
- * Pick one controller per monitoring event.  L3 OCCUP comes from the
- * picked L3 CC (if mon_capable).
+ * Pick one controller per monitoring event. L3 OCCUP comes from the
+ * picked L3 CC (if mon_capable). MBM_TOTAL from the only mon-capable BC.
  */
 static void cbqri_resctrl_pick_counters(void)
 {
@@ -827,6 +947,9 @@ static void cbqri_resctrl_pick_counters(void)
 
 	if (l3->ctrl && l3->ctrl->mon_capable)
 		cbqri_resctrl_counters[QOS_L3_OCCUP_EVENT_ID] = l3->ctrl;
+
+	cbqri_resctrl_counters[QOS_L3_MBM_TOTAL_EVENT_ID] =
+		cbqri_find_only_mon_bc();
 }
 
 static void cbqri_resctrl_accumulate_caps(void)
@@ -949,6 +1072,29 @@ static int cbqri_attach_cpu_to_l3_mon(struct cbqri_controller *ctrl,
 	if (err)
 		goto err_offline;
 
+	/*
+	 * Pair this L3 domain with the system's mon-capable BC. The
+	 * cached pointer is consulted by every rmid_read / reset_rmid.
+	 * BC mon init is system-wide. Failure here means mbm_total_bytes
+	 * is unusable for any domain, so fail the attach.
+	 */
+	{
+		struct cbqri_resctrl_dom *hw_dom = container_of(ctrl_dom,
+								struct cbqri_resctrl_dom,
+								resctrl_ctrl_dom);
+
+		hw_dom->paired_bc = cbqri_find_only_mon_bc();
+		if (hw_dom->paired_bc) {
+			err = cbqri_init_bc_mon_counters(hw_dom->paired_bc);
+			if (err) {
+				pr_err("BC @%pa: mon init failed (%d)\n",
+				       &hw_dom->paired_bc->addr, err);
+				hw_dom->paired_bc = NULL;
+				goto err_offline;
+			}
+		}
+	}
+
 	return 0;
 
 err_offline:

-- 
2.43.0

