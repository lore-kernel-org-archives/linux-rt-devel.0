Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C63B8922;
	Sun, 24 May 2026 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667068; cv=none; b=EtOgNCvNJXcMDzuQMskP7dQEpooIUNQuxRKa4+PD8I72NdYr4RuYteCe0RNxMu2EqnLwurnX+dgZxtHn2ReUmheQJoH/8VQbmxup62M4MpeAFXYsMtlsjJ+ZcmnzxCFVcRHTJatqW2vy4a0kF1ZqGnAj6Og+kO0N99Cut/QyHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667068; c=relaxed/simple;
	bh=cQZIxogxHi6/a1bq9hWHDBDDLMtTIO/xab7UaBUTm3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opJsY3lkYsc+MlHYA1GsD6eZX5pbQfIMFGwIVt1A56I9rKrMmwG//Qe29hT6J0wQX1H8iEryHYFZJ63PlGd5e42SM0QYbmdC8ophwbq4C/ngiNaXbO09Dc5nlViU/55x68JG4Ovxtc3UaGt6RcLSBMEgt2VzK3yuA+5cdwvZmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UschymkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UschymkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BE31F0155E;
	Sun, 24 May 2026 23:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667062;
	bh=EllR/1CEo+TtZv0/iyFInnJU3GZT/dZGiV/si/OJVsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UschymkLhpsZAcrY4tvBRbXe5RxmMF0kfbcCiyoO4888lSnqXCJImwKldXyGvOYYk
	 IkZRp4CYDfZzhOidA7rgFJtvaM1O5WzNqPcHCk9/UekwMOvWGkNNvg+DBl9wOA6GEv
	 +N3UwHBEUByKzEEI/0p3m4TpXsM03wgoA1Ss8ilpIqqLSkPtVQUxMTh83oGcNZI32b
	 1QCpi2QkAqHYAD7/cSmWZ2Nf7WqDRFhKHM+3gEeNmfFLzUXQRcdH3KDczdWz6DjSrL
	 7SJM/VRo/wnkkjQqO1twyaCEwDNxC5Vi4rP/jHpB4HkePGqtl/paKoJNKWKPAzkwzi
	 sFnFJxI/MNUgg==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:45 -0700
Subject: [PATCH RFC v5 15/18] riscv_cbqri: resctrl: Add mbm_total_bytes
 bandwidth monitoring
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-15-78d3a7ba9dbe@kernel.org>
References: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
In-Reply-To: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
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
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9431; i=fustini@kernel.org;
 h=from:subject:message-id; bh=cQZIxogxHi6/a1bq9hWHDBDDLMtTIO/xab7UaBUTm3o=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8i8+oHZvP8y25zQxHjb5zfcdFP1Qj76r1At+Ni5m
 fWip65HRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAi2x8y/GSc8nJ+9HLnCWuq
 uXfKesroLz+Q1bGI5XPrw8v1ss4xkY6MDB81GRmknE9s+yPQb/l0TX6Pb0Kxx/fzLUsKpGS/BQr
 4cwEA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Expose CBQRI bandwidth controller's combined read+write counter as
the L3 mbm_total_bytes event. A software accumulator keeps the
64-bit byte total monotonic across the 62-bit hardware counter wrap.

mbm_local_bytes is not supported because the CBQRI spec has no way
to distinguish total versus local. mbm_total_bytes is enabled only
when the platform exposes exactly one mon-capable bandwidth
controller and exactly one L3 domain. Pairing a single BC with
multiple L3 domains would let standard userspace tools overcount
system bandwidth by summing the same counter across domains.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 191 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index ba764bc6ef17..f11709d7e479 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -29,6 +29,13 @@ struct cbqri_resctrl_res {
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
@@ -37,7 +44,7 @@ static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
  * Per-event controller table. Only events CBQRI can back occupy a
  * slot, so other events do not bloat the array.
  */
-#define CBQRI_MAX_EVENT QOS_L3_OCCUP_EVENT_ID
+#define CBQRI_MAX_EVENT QOS_L3_MBM_TOTAL_EVENT_ID
 static struct cbqri_controller *cbqri_resctrl_counters[CBQRI_MAX_EVENT + 1];
 
 static bool exposed_alloc_capable;
@@ -228,6 +235,36 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d
 		mutex_unlock(&ctrl->lock);
 		break;
 
+	case QOS_L3_MBM_TOTAL_EVENT_ID: {
+		struct cbqri_controller *bc;
+
+		cd = cbqri_find_ctrl_domain(&r->ctrl_domains, d->hdr.id);
+		if (!cd)
+			break;
+		hw_dom = container_of(cd, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		bc = hw_dom->paired_bc;
+		if (!bc)
+			break;
+		if (WARN_ON_ONCE(!bc->mbm_total_states))
+			break;
+		if (rmid >= bc->mcid_count)
+			break;
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
+		break;
+	}
+
 	default:
 		break;
 	}
@@ -240,8 +277,10 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domai
 	int i;
 
 	/* Bound by max_rmid (system-wide minimum mcid_count). */
-	for (i = 0; i < max_rmid; i++)
+	for (i = 0; i < max_rmid; i++) {
 		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_OCCUP_EVENT_ID);
+		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_MBM_TOTAL_EVENT_ID);
+	}
 }
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
@@ -305,6 +344,82 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 		mutex_unlock(&ctrl->lock);
 		break;
 
+	case QOS_L3_MBM_TOTAL_EVENT_ID: {
+		struct cbqri_controller *bc;
+
+		/*
+		 * The L3 monitoring domain's id is the L3 cache id. The
+		 * matching ctrl domain's hw_dom->paired_bc was cached at
+		 * add time to avoid walking cbqri_controllers on every read.
+		 */
+		d = cbqri_find_ctrl_domain(&r->ctrl_domains, hdr->id);
+		if (!d) {
+			err = -ENOENT;
+			break;
+		}
+		hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		bc = hw_dom->paired_bc;
+		if (!bc) {
+			err = -ENOENT;
+			break;
+		}
+		if (WARN_ON_ONCE(!bc->mbm_total_states)) {
+			err = -EIO;
+			break;
+		}
+		if (rmid >= bc->mcid_count) {
+			err = -ERANGE;
+			break;
+		}
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
+			 * Return the last good total and leave prev_ctr so
+			 * the next valid sample resumes from there.
+			 */
+			*val = bc->mbm_total_states[rmid].chunks;
+		} else if (ctr_val & CBQRI_BC_MON_CTR_VAL_OVF) {
+			/*
+			 * OVF is sticky until next CONFIG_EVENT.
+			 * cbqri_bc_mon_overflow() can recover at most
+			 * one wrap. With OVF set, the count is unknown,
+			 * so re-arm and re-anchor prev_ctr=0.
+			 */
+			struct cbqri_bc_mon_state *s = &bc->mbm_total_states[rmid];
+
+			pr_warn_ratelimited("BC@%pa MCID %u: bandwidth counter overflow\n",
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
+		break;
+	}
+
 	default:
 		err = -EINVAL;
 		break;
@@ -738,6 +853,15 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 			res->mon.num_rmid = ctrl->mcid_count;
 			resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID,
 						 false, 0, NULL);
+
+			/*
+			 * Expose BC bandwidth monitoring as the L3's
+			 * mbm_total_bytes when they share topology.
+			 */
+			if (cbqri_resctrl_counters[QOS_L3_MBM_TOTAL_EVENT_ID])
+				resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID,
+							 false, 0, NULL);
+
 			res->mon_capable = true;
 		}
 		break;
@@ -824,15 +948,54 @@ static int cbqri_resctrl_pick_bw_alloc(void)
 }
 
 /*
- * Pick one controller per monitoring event.  L3 OCCUP comes from the
- * picked L3 CC (if mon_capable).
+ * Pick one controller per monitoring event. L3 OCCUP comes from the
+ * picked L3 CC if mon_capable. MBM_TOTAL from the only mon-capable BC,
+ * but only when the system exposes exactly one L3 cache. Pairing a
+ * single BC with multiple L3 domains would overcount system bandwidth
+ * by a factor equal to the L3 domain count.
  */
 static void cbqri_resctrl_pick_counters(void)
 {
 	struct cbqri_resctrl_res *l3 = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
+	struct cbqri_controller *ctrl, *prev;
+	unsigned int l3_count = 0;
 
 	if (l3->ctrl && l3->ctrl->mon_capable)
 		cbqri_resctrl_counters[QOS_L3_OCCUP_EVENT_ID] = l3->ctrl;
+
+	/* Count distinct L3 cache_ids */
+	list_for_each_entry(ctrl, &cbqri_controllers, list) {
+		bool seen = false;
+
+		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
+			continue;
+		if (ctrl->cache.cache_level != 3)
+			continue;
+
+		list_for_each_entry(prev, &cbqri_controllers, list) {
+			if (prev == ctrl)
+				break;
+			if (prev->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
+				continue;
+			if (prev->cache.cache_level != 3)
+				continue;
+			if (prev->cache.cache_id == ctrl->cache.cache_id) {
+				seen = true;
+				break;
+			}
+		}
+		if (!seen)
+			l3_count++;
+	}
+
+	if (l3_count > 1) {
+		pr_warn_once("multiple L3 domains (%u) detected. mbm_total_bytes disabled\n",
+			     l3_count);
+		return;
+	}
+
+	cbqri_resctrl_counters[QOS_L3_MBM_TOTAL_EVENT_ID] =
+		cbqri_find_only_mon_bc();
 }
 
 static void cbqri_resctrl_accumulate_caps(void)
@@ -948,6 +1111,26 @@ static int cbqri_attach_cpu_to_l3_mon(struct cbqri_controller *ctrl,
 	else
 		list_add_tail(&mon_dom->hdr.list, &res->mon_domains);
 
+	/*
+	 * Pair this L3 domain with the system's mon-capable BC and
+	 * initialise the BC's per-MCID software accumulators before
+	 * resctrl_online_mon_domain() exposes the domain to userspace.
+	 * A concurrent sysfs read of mbm_total_bytes between online and
+	 * BC init would otherwise pass the !bc->mbm_total_states check
+	 * with a half-initialised pointer.
+	 */
+	hw_dom = container_of(ctrl_dom, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+
+	hw_dom->paired_bc = cbqri_find_only_mon_bc();
+	if (hw_dom->paired_bc) {
+		err = cbqri_init_bc_mon_counters(hw_dom->paired_bc);
+		if (err) {
+			pr_err("BC @%pa: mon init failed (%d)\n", &hw_dom->paired_bc->addr, err);
+			hw_dom->paired_bc = NULL;
+			goto err_listdel;
+		}
+	}
+
 	err = resctrl_online_mon_domain(res, &mon_dom->hdr);
 	if (err)
 		goto err_listdel;

-- 
2.43.0

