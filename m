Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997F3B83F9;
	Sun, 24 May 2026 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667066; cv=none; b=F/8J298knfUJmx5oz27Io1iPeiQ5Qhedq8tpLQ7x9mxJ6dn2mC324xuBjesJDm3D064PVPtOTOqAQ1D2WgogBGNzIsK05sB2YZ5w0vmmKzog8YI8V/m4XxqrPeGioJXtG1N+h99qwf5ZO3eJBa5HOChbu/rsAx/V5CYAzABwIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667066; c=relaxed/simple;
	bh=LeGE4Ls7k9VnbGMk2R/vZx28T4pQeXBFY+LQE7hv70A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3d6v5KCLMQ3HQwPl6Ldzg5rbakwogb4drCjy8NRn33i57USfKUHp0SXz2YfEWpkz+aoWbvGUxHzWdU2RNthUmU95E3dBTb3pgWBrpHRGxwcHlLJ4tLjTP7UCv3FiMx3fnwEjaqZdZ8C+ZyRgyosxPe3PcA758vZ+4VoF2nPOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G52UO2GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G52UO2GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259DE1F01564;
	Sun, 24 May 2026 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667060;
	bh=TTkMXHPpCkrw9mbhNwao6LVZ1u7oRci0wj3I02xL/w0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G52UO2GXD1I/3xfwfQLYO0q+ktsvBNSHesAeVGlmoQkGCUroAdEZeFGc+KTH9IPk+
	 vNLOaAuCqGeLpGBc6ey+mF24zdcr13q+2Oiq2q0xCeZlpVve8DCI+7D0FuhbC0uotA
	 sMSYOJL1wNmygSW9xmAvTcM2sHEpmbC1+u0/9N+SgqB6+S4edjNMcItVcqDfc+ceAA
	 lQcGL30ukvj28Ge40Z+3BDnUNwSL/JWLUmhrI525P/jRqstj0O9qm0XcwyjKyuHVrM
	 QFCVOUBJ2Xw40rooOci2qMif4aJm5/dk3yKS4dK2D1Hm84EaWII0zO3K1PsIS8KnPX
	 NOVG41K4YAgOA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:43 -0700
Subject: [PATCH RFC v5 13/18] riscv_cbqri: resctrl: Add MB_MIN bandwidth
 allocation via Rbwb
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-13-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10637; i=fustini@kernel.org;
 h=from:subject:message-id; bh=LeGE4Ls7k9VnbGMk2R/vZx28T4pQeXBFY+LQE7hv70A=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8i8PXuaxNKAxDqbNeumnXp8/snWdiaB3Eh59t6dt
 oJZocpLO0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATuVvA8L/qr37vhWmX7oZu
 Mm/vOP1ofcvPH/4bXnWsnV7jYezWtng3w/+ot2ozf09sXPl6b8fSgr98PS8ve4t8VFy3tr39xK5
 /pX+YAQ==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add bandwidth allocation through Rbwb (reserved bandwidth blocks)
exposed as the MB_MIN resource. Rbwb's sum constraint does not fit MBA's
percentage cap, so MB_MIN lands as a new RDT_RESOURCE_* rather than
masquerading as MBA.

The sum(Rbwb) <= MRBWB (max resv bw blocks) invariant from the CBQRI
spec is enforced at schemata-write time using a per-RCID software cache
under ctrl->lock. -EINVAL on overflow, matching the existing
schemata-write rejection convention.

Reset gives RCID 0 the remaining MRBWB budget after reserving 1 block
per other RCID. default_to_min=true on MB_MIN so mkdir cannot overflow
the sum constraint.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 220 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 198 insertions(+), 22 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index 3ba895c3f811..5d8389c58f4f 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -411,6 +411,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
 		return cbqri_apply_cache_config_dom(dom, r, closid, t, cfg_val);
+	case RDT_RESOURCE_MB_MIN:
+		/* sum(Rbwb) <= MRBWB validation runs inside cbqri_apply_rbwb(). */
+		return cbqri_apply_rbwb(dom->hw_ctrl, closid, cfg_val, true);
 	default:
 		return -EINVAL;
 	}
@@ -463,6 +466,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 		if (err < 0)
 			val = resctrl_get_default_ctrl(r);
 		break;
+	case RDT_RESOURCE_MB_MIN: {
+		u64 rbwb;
+
+		err = cbqri_read_rbwb(ctrl, closid, &rbwb);
+		if (err == 0)
+			val = (u32)rbwb;
+		break;
+	}
 	default:
 		break;
 	}
@@ -470,9 +481,22 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	return val;
 }
 
+/*
+ * RCID 0 carries the remaining MRBWB after every other RCID is seeded with
+ * the minimum Rbwb of 1. cbqri_probe_bc() rejects a bandwidth controller
+ * with mrbwb < rcid_count, so this subtraction cannot underflow.
+ */
+static u64 cbqri_rcid0_rbwb(struct cbqri_controller *ctrl)
+{
+	if (WARN_ON_ONCE(ctrl->bc.mrbwb < ctrl->rcid_count))
+		return 1;
+	return ctrl->bc.mrbwb - (ctrl->rcid_count - 1);
+}
+
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
 	struct cbqri_resctrl_res *hw_res;
+	struct cbqri_resctrl_dom *dom;
 	struct rdt_ctrl_domain *d;
 	enum resctrl_conf_type t;
 	u32 default_ctrl;
@@ -487,15 +511,41 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 		return;
 
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
-			for (t = 0; t < CDP_NUM_TYPES; t++) {
+		dom = container_of(d, struct cbqri_resctrl_dom,
+				   resctrl_ctrl_dom);
+
+		switch (r->rid) {
+		case RDT_RESOURCE_MB_MIN:
+			/*
+			 * CBQRI section 4.5: Rbwb >= 1, sum(Rbwb) <= MRBWB.
+			 * Walk N-1..1 first so RCID 0 lands last with the
+			 * remaining budget.
+			 */
+			for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+				u32 rcid = (i + 1) % hw_res->ctrl->rcid_count;
+				u64 rbwb = (rcid == 0) ?
+					cbqri_rcid0_rbwb(dom->hw_ctrl) : 1;
 				int rerr;
 
-				rerr = resctrl_arch_update_one(r, d, i, t, default_ctrl);
+				rerr = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
 				if (rerr)
-					pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
-							   r->rid, i, t, rerr);
+					pr_err_ratelimited("RBWB reset RCID %u failed (%d)\n",
+							   rcid, rerr);
 			}
+			break;
+		default:
+			for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+				for (t = 0; t < CDP_NUM_TYPES; t++) {
+					int rerr;
+
+					rerr = resctrl_arch_update_one(r, d, i, t,
+								       default_ctrl);
+					if (rerr)
+						pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
+								   r->rid, i, t, rerr);
+				}
+			}
+			break;
 		}
 	}
 }
@@ -520,26 +570,51 @@ static struct rdt_ctrl_domain *cbqri_new_domain(struct cbqri_controller *ctrl)
 static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	struct cbqri_resctrl_res *hw_res;
+	struct cbqri_resctrl_dom *dom;
 	enum resctrl_conf_type t;
 	int err = 0;
+	u64 rbwb;
 	int i;
 
 	hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
+	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
 
 	for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
 		/*
-		 * Seed both DATA and CODE staged slots so a later mount
-		 * with -o cdp does not see stale CODE values.
-		 * On non-AT controllers cbqri_cc_alloc_op() masks AT to 0
-		 * so all three iterations land on the same hardware state.
-		 * The redundant writes are harmless.
+		 * For MB_MIN walk, RCIDs 1..N-1 then RCID 0 last so the sum
+		 * doesn't exceed MRBWB during the walk.
 		 */
-		for (t = 0; t < CDP_NUM_TYPES; t++) {
-			err = resctrl_arch_update_one(r, d, i, t,
-						      resctrl_get_default_ctrl(r));
-			if (err)
-				return err;
+		u32 rcid = (r->rid == RDT_RESOURCE_MB_MIN) ?
+				((i + 1) % hw_res->ctrl->rcid_count) : i;
+
+		switch (r->rid) {
+		case RDT_RESOURCE_MB_MIN:
+			/*
+			 * CBQRI section 4.5: Rbwb >= 1, sum(Rbwb) <= MRBWB.
+			 * RCID 0 takes the remaining budget.
+			 */
+			rbwb = (rcid == 0) ? cbqri_rcid0_rbwb(dom->hw_ctrl) : 1;
+
+			err = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
+			break;
+		default:
+			/*
+			 * Seed both DATA and CODE staged slots so a later
+			 * mount with -o cdp does not see stale CODE values.
+			 * On non-AT controllers cbqri_cc_alloc_op() masks
+			 * AT to 0, so all three iterations land on the same
+			 * hardware state. The redundant writes are harmless.
+			 */
+			for (t = 0; t < CDP_NUM_TYPES; t++) {
+				err = resctrl_arch_update_one(r, d, i, t,
+							      resctrl_get_default_ctrl(r));
+				if (err)
+					break;
+			}
+			break;
 		}
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -639,6 +714,31 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 			res->mon_capable = true;
 		}
 		break;
+
+	case RDT_RESOURCE_MB_MIN:
+		res->name = "MB_MIN";
+		res->schema_fmt = RESCTRL_SCHEMA_RANGE;
+		/*
+		 * resctrl requires a cache scope for MBA-style domains.
+		 * Use L3 as a proxy until the resctrl supports non-cache
+		 * scopes for bandwidth resources.
+		 */
+		res->ctrl_scope = RESCTRL_L3_CACHE;
+		/* Rbwb is an integer block count, not a percentage. No MBA delay_linear. */
+		res->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
+		res->membw.min_bw = 1;
+		res->membw.max_bw = ctrl->bc.mrbwb;
+		res->membw.bw_gran = 1;
+		/*
+		 * CBQRI section 4.5 caps sum(Rbwb) <= MRBWB. Default new
+		 * groups to min_bw so mkdir cannot overflow that sum.
+		 */
+		res->membw.default_to_min = true;
+		res->alloc_capable = ctrl->alloc_capable;
+		INIT_LIST_HEAD(&res->ctrl_domains);
+		INIT_LIST_HEAD(&res->mon_domains);
+		break;
+
 	default:
 		break;
 	}
@@ -646,6 +746,37 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 	return 0;
 }
 
+/*
+ * Pick one BC to back MB_MIN.  Multiple BCs must agree on rcid_count
+ * and mrbwb.  Mismatch is fatal because resctrl exposes a single set
+ * of caps per rid.
+ */
+static int cbqri_resctrl_pick_bw_alloc(void)
+{
+	struct cbqri_resctrl_res *mb_min = &cbqri_resctrl_resources[RDT_RESOURCE_MB_MIN];
+	struct cbqri_controller *ctrl;
+
+	list_for_each_entry(ctrl, &cbqri_controllers, list) {
+		if (ctrl->type != CBQRI_CONTROLLER_TYPE_BANDWIDTH)
+			continue;
+		if (!ctrl->alloc_capable)
+			continue;
+
+		if (mb_min->ctrl) {
+			if (mb_min->ctrl->rcid_count != ctrl->rcid_count ||
+			    mb_min->ctrl->bc.mrbwb != ctrl->bc.mrbwb) {
+				pr_err("BW controllers have mismatched capabilities\n");
+				return -EINVAL;
+			}
+			continue;
+		}
+
+		mb_min->ctrl = ctrl;
+	}
+
+	return 0;
+}
+
 /*
  * Pick one controller per monitoring event.  L3 OCCUP comes from the
  * picked L3 CC (if mon_capable).
@@ -860,6 +991,37 @@ static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 	return err;
 }
 
+static int cbqri_attach_cpu_to_one_bw_res(struct cbqri_controller *ctrl,
+					  enum resctrl_res_level rid,
+					  unsigned int cpu)
+{
+	struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
+	struct rdt_resource *res = &hw_res->resctrl_res;
+	struct rdt_ctrl_domain *domain;
+	int dom_id = ctrl->mem.prox_dom;
+
+	if (!hw_res->ctrl)
+		return 0;
+
+	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
+	if (domain) {
+		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
+		return 0;
+	}
+
+	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	return 0;
+}
+
+static int cbqri_attach_cpu_to_bw_ctrl(struct cbqri_controller *ctrl,
+				       unsigned int cpu)
+{
+	return cbqri_attach_cpu_to_one_bw_res(ctrl, RDT_RESOURCE_MB_MIN, cpu);
+}
+
 static void cbqri_detach_cpu_from_l3_mon(struct rdt_resource *res,
 					 unsigned int cpu)
 {
@@ -937,6 +1099,10 @@ static int cbqri_resctrl_setup(void)
 	if (err)
 		return err;
 
+	err = cbqri_resctrl_pick_bw_alloc();
+	if (err)
+		return err;
+
 	cbqri_resctrl_pick_counters();
 
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
@@ -983,14 +1149,24 @@ static int cbqri_resctrl_online_cpu(unsigned int cpu)
 	mutex_lock(&cbqri_domain_list_lock);
 
 	list_for_each_entry(ctrl, &cbqri_controllers, list) {
-		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
-			continue;
-		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
-			continue;
-		if (!ctrl->alloc_capable)
+		switch (ctrl->type) {
+		case CBQRI_CONTROLLER_TYPE_CAPACITY:
+			if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
+				continue;
+			if (!ctrl->alloc_capable)
+				continue;
+			err = cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
+			break;
+		case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+			if (!cpumask_test_cpu(cpu, &ctrl->mem.cpu_mask))
+				continue;
+			if (!ctrl->alloc_capable)
+				continue;
+			err = cbqri_attach_cpu_to_bw_ctrl(ctrl, cpu);
+			break;
+		default:
 			continue;
-
-		err = cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
+		}
 		if (err)
 			break;
 	}

-- 
2.43.0

