Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1B3803EB;
	Mon, 11 May 2026 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476278; cv=none; b=XrdQ8cPfcHTfABoRf6+Eho/5DV8qsTNjIOS7bun+/GBKXn1usH/Qa/Hn+HmNmuK1Z7xklhAYAwlx+I8Tj73QZVNTQNZDj3heyUsSSlai4JuLGmiXouvqIibwDJSQURvUgOPpWJXvAYtdH1njVjC0XWEp95FS3ihl6h4hEj7c+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476278; c=relaxed/simple;
	bh=VPbiNuYkj943RWCZZFZdtSyQPqpJtL1RkE7j9lfDjHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqhOoVbx72rPhL/91atM/chfwgu4hgxyOThcP6QOLPxRTggaf2/XAc7UgimjWiMZxmpKZurHGAKAVJSXLxnpUljjmodff5Z8Htg1CxN3zx/XiZKhBp5mbxjJMlJOjDR/Zbqqof0b+2L00zpBpqfzi8cGimoSpYvBThK+vk1sUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQXOzmv0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQXOzmv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DCCC2BCFA;
	Mon, 11 May 2026 05:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476278;
	bh=VPbiNuYkj943RWCZZFZdtSyQPqpJtL1RkE7j9lfDjHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQXOzmv0+k63AvJ+cMheh4iciQyz90WLYTn65xkta5nZ43vltVbdHDT3TNO6KLnSE
	 KdGlqVlI4t53bHsL44Nh3Ia3l5mA1r5DNkjMz+Z1gouuYZQ826R46cG9rVT0HAohn4
	 bZWUAPsicRHuFM+8aA+9b6FUYSRGdBV/nxwwY5RLHiowwK9Q/e75jFZw8jVmK2L/k6
	 MZ5RYYg9HIiVqUBDPKvu5oMNNWshc0PM8Fd886hUTsmSDpMfQZKWc44J+u9rqJeRtF
	 kDnYq2BC6d8xL8+vOrG0VDq+E67R34Ntd2THtWG7K7K0XcPK3Iz1hTurUjUKbCmvIB
	 tqKI8cBfYNLKw==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:09 -0700
Subject: [PATCH RFC v4 13/18] riscv_cbqri: resctrl: Add MB_MIN bandwidth
 allocation via Rbwb
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-13-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10199; i=fustini@kernel.org;
 h=from:subject:message-id; bh=VPbiNuYkj943RWCZZFZdtSyQPqpJtL1RkE7j9lfDjHQ=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprzuORRdd17XtC8nWsRqRaXDfLuzTLzWlpNMgw0dH
 E6Lfp/VUcrCIMbFICumyLLpQ96FJV6hXxfMf7ENZg4rE8gQBi5OAZjInC2MDOeZCxMrLppfme3J
 mvpLLmP1n9gbUw+eu/Zq5z792fGv+hoYfrM1GFiZNGa8XXLo39YpPc38HbUBd24x6kUtNJdX21x
 7iw0A
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
 drivers/resctrl/cbqri_resctrl.c | 209 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 189 insertions(+), 20 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index d8fd9b06703f..bcd9367e3555 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -415,6 +415,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
 		return cbqri_apply_cache_config_dom(dom, r, closid, t, cfg_val);
+	case RDT_RESOURCE_MB_MIN:
+		/* sum(Rbwb) <= MRBWB validation runs inside cbqri_apply_rbwb(). */
+		return cbqri_apply_rbwb(dom->hw_ctrl, closid, cfg_val, true);
 	default:
 		return -EINVAL;
 	}
@@ -467,6 +470,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
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
@@ -477,6 +488,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
 	struct cbqri_resctrl_res *hw_res;
+	struct cbqri_resctrl_dom *dom;
 	struct rdt_ctrl_domain *d;
 	enum resctrl_conf_type t;
 	u32 default_ctrl;
@@ -491,15 +503,42 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
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
+			 * Walk N-1..1 first so the final sum lands at
+			 * MRBWB. Use the unchecked helper since the
+			 * intermediate sum may exceed MRBWB.
+			 */
+			for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+				u32 rcid = (i + 1) % hw_res->ctrl->rcid_count;
+				u64 rbwb = (rcid == 0) ?
+					dom->hw_ctrl->bc.mrbwb - (hw_res->ctrl->rcid_count - 1) : 1;
 				int rerr;
 
-				rerr = resctrl_arch_update_one(r, d, i, t, default_ctrl);
+				rerr = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
 				if (rerr)
-					pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
-							   r->rid, i, t, rerr);
+					pr_err_ratelimited("RBWB reset RCID %u failed (%d)\n",
+							   rcid, rerr);
+			}
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
 			}
+			break;
 		}
 	}
 }
@@ -524,24 +563,53 @@ static struct rdt_ctrl_domain *cbqri_new_domain(struct cbqri_controller *ctrl)
 static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	struct cbqri_resctrl_res *hw_res;
+	struct cbqri_resctrl_dom *dom;
 	enum resctrl_conf_type t;
 	int err = 0;
 	int i;
 
 	hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
+	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
 
 	for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
 		/*
-		 * Seed both DATA and CODE staged slots so a later mount
-		 * with -o cdp does not see stale CODE values.
-		 * CDP_NUM_TYPES is 1 on non-CDP controllers.
+		 * For MB_MIN walk RCIDs 1..N-1 then RCID 0 last so the sum
+		 * trends toward MRBWB during the walk. Other rids iterate
+		 * in natural order.
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
+		case RDT_RESOURCE_MB_MIN: {
+			/*
+			 * CBQRI section 4.5: Rbwb >= 1, sum(Rbwb) <= MRBWB.
+			 * RCID 0 gets the remaining budget. Use the
+			 * unchecked helper since intermediate states
+			 * transiently exceed MRBWB.
+			 */
+			u64 rbwb = (rcid == 0) ?
+				dom->hw_ctrl->bc.mrbwb - (hw_res->ctrl->rcid_count - 1) : 1;
+
+			err = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
+			break;
 		}
+		default:
+			/*
+			 * Seed both DATA and CODE staged slots so a later
+			 * mount with -o cdp does not see stale CODE values.
+			 * CDP_NUM_TYPES is 1 on non-CDP controllers.
+			 */
+			for (t = 0; t < CDP_NUM_TYPES; t++) {
+				err = resctrl_arch_update_one(r, d, i, t,
+							      resctrl_get_default_ctrl(r));
+				if (err)
+					break;
+			}
+			break;
+		}
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -638,6 +706,31 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 			res->mon_capable = true;
 		}
 		break;
+
+	case RDT_RESOURCE_MB_MIN:
+		res->name = "MB_MIN";
+		res->schema_fmt = RESCTRL_SCHEMA_RANGE;
+		/*
+		 * resctrl requires a cache scope for MBA-style domains.
+		 * Use L3 as a proxy until the framework supports non-cache
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
@@ -645,6 +738,37 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
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
@@ -830,6 +954,37 @@ static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 	return 0;
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
@@ -910,6 +1065,10 @@ static int cbqri_resctrl_setup(void)
 	if (err)
 		return err;
 
+	err = cbqri_resctrl_pick_bw_alloc();
+	if (err)
+		return err;
+
 	cbqri_resctrl_pick_counters();
 
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
@@ -941,14 +1100,24 @@ static int cbqri_resctrl_online_cpu(unsigned int cpu)
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

