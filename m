Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F13FD133;
	Mon,  1 Jun 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346196; cv=none; b=pNqO+wY5vgs2Za7xIypht2KtFoC0PHf+ZdrOw0FxjUylSNUNhKt0xt/FVDWuzfQ0AVUkSqZ4jYOGrVJTj8vcB6+o0ecAro0F4O0YGhz4LmoMb+ygMGsPqpMZ0LMgI+8VrEy7/ShDgmOSjtBJqbM9hcYOHlSTmwiW1rGlhvdQUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346196; c=relaxed/simple;
	bh=iGmU2buwnXjB4e9q+wmO+AF3FTtZ91gPnMFZh5ljUS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzhvRQJZHq8bwuydlY1W6V0ufIjeT2fzeNU2KDPJjo0V+uxVjXlhN3m7XsEyEcBEX4tJ3gm/7jhDf7QbM/YUFJi89RP6uCltzuPdinEaAsoRds/m26lFIZaqJPuBgYpIHYAKwTfPCNfnuKnqS/X/MlDg6Bm03YiVZZ+mTQU+2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVjlcBM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVjlcBM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37881F008A3;
	Mon,  1 Jun 2026 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346194;
	bh=dJAikZQYxnYTaHzwnrk2IbarfqlW+ddABQCi4DNR2AE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NVjlcBM2BjZlnph9DGLWGCVwXFHt1fytBqkRR8t4nsLMHdtajNSm4O46l0YOE5CE4
	 ZIY9mxxtJrMgx0vn8xUYAZi6LDy/V8u4LEEzrVXzo2oTovyn4RD92D5Vla++r+d6gi
	 TAfb1JRntJH5+FFNWxiny6C1ldnnn5c//zj79EKn79dpuCn3iW3aIguIgyoT1Ty1Y3
	 ffhAbA3PJjB0BpR2Eu9QhwHL4TTiAy0yxdgNmr2dx62vJ64wN9IrdrFx/y1c9iYz7u
	 cy+E7hX1pdnJNCMScmsw4F+xWN+uj7k4nsGlWsxpkYxo9gHK47M1qejhjYxKY/s4lg
	 cdRYpwk4mjUMw==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:08 -0700
Subject: [PATCH RFC v6 14/18] riscv_cbqri: resctrl: Add MB_WGHT bandwidth
 allocation via Mweight
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-14-baf00f50028a@kernel.org>
References: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
In-Reply-To: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6210; i=fustini@kernel.org;
 h=from:subject:message-id; bh=iGmU2buwnXjB4e9q+wmO+AF3FTtZ91gPnMFZh5ljUS0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnW50enmE3yv+UTkya5LOWs2Rr7ms52wX4BrVonbL
 mbfX/YGHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJvMtmZLhWs2Yq24KJN3VO
 Pi1Niz1Q25++Qipzj4RXYjZ30evtk94x/M9dLejvIOH94A5T2MYpNfG18wt0a85xfV749m67ovU
 RAUYA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add bandwidth allocation through Mweight (shared weight for unreserved
bandwidth) exposed as the MB_WGHT resource. Mweight has no MBA
equivalent, so it lands as a new RDT_RESOURCE_*.

Mweight is an integer in [0, 255]. A value of 0 disables work-
conserving sharing for the group, capping its bandwidth at the
MB_MIN reservation. Values 1..255 compete for the leftover pool in
proportion to the weight.

The same BC backs both MB_MIN and MB_WGHT and bc_bw_alloc packs Rbwb and
Mweight in one register. cbqri_attach_cpu_to_bw_ctrl() attaches both
rids to the picked BC.

Reset gives every RCID the new-group default (max_bw = 255) for
equal opportunistic shares.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index 1d312004b07d..14b955eb7949 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -366,6 +366,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	case RDT_RESOURCE_MB_MIN:
 		/* sum(Rbwb) <= MRBWB validation runs inside cbqri_apply_rbwb(). */
 		return cbqri_apply_rbwb(dom->hw_ctrl, closid, cfg_val, true);
+	case RDT_RESOURCE_MB_WGHT:
+		return cbqri_apply_mweight_config(dom->hw_ctrl, closid, cfg_val);
 	default:
 		return -EINVAL;
 	}
@@ -426,6 +428,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			val = (u32)rbwb;
 		break;
 	}
+	case RDT_RESOURCE_MB_WGHT: {
+		u64 mweight;
+
+		err = cbqri_read_mweight(ctrl, closid, &mweight);
+		if (err == 0)
+			val = (u32)mweight;
+		break;
+	}
 	default:
 		break;
 	}
@@ -485,6 +495,18 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 							   rcid, rerr);
 			}
 			break;
+		case RDT_RESOURCE_MB_WGHT:
+			/* All RCIDs start at max weight (the new-group default). */
+			for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+				int rerr;
+
+				rerr = cbqri_apply_mweight_config(dom->hw_ctrl, i,
+								  default_ctrl);
+				if (rerr)
+					pr_err_ratelimited("Mweight reset RCID %u failed (%d)\n",
+							   i, rerr);
+			}
+			break;
 		default:
 			for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
 				for (t = 0; t < CDP_NUM_TYPES; t++) {
@@ -549,6 +571,11 @@ static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_dom
 
 			err = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
 			break;
+		case RDT_RESOURCE_MB_WGHT:
+			/* Match the new-group default: equal weights across RCIDs. */
+			err = cbqri_apply_mweight_config(dom->hw_ctrl, i,
+							 resctrl_get_default_ctrl(r));
+			break;
 		default:
 			/*
 			 * Seed both DATA and CODE staged slots so a later
@@ -690,6 +717,25 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 		INIT_LIST_HEAD(&res->mon_domains);
 		break;
 
+	case RDT_RESOURCE_MB_WGHT:
+		res->name = "MB_WGHT";
+		res->schema_fmt = RESCTRL_SCHEMA_RANGE;
+		res->ctrl_scope = RESCTRL_L3_CACHE;
+		/* Mweight is a dimensionless ratio. No delay/linear concept. */
+		res->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
+		/*
+		 * CBQRI section 4.5: Mweight is 0-255 (0 disables
+		 * work-conserving). No sum constraint, so leave
+		 * default_to_min false. Groups default to max_bw.
+		 */
+		res->membw.min_bw = 0;
+		res->membw.max_bw = 255;
+		res->membw.bw_gran = 1;
+		res->alloc_capable = ctrl->alloc_capable;
+		INIT_LIST_HEAD(&res->ctrl_domains);
+		INIT_LIST_HEAD(&res->mon_domains);
+		break;
+
 	default:
 		break;
 	}
@@ -698,13 +744,12 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 }
 
 /*
- * Pick one BC to back MB_MIN.  Multiple BCs must agree on rcid_count
- * and mrbwb.  Mismatch is fatal because resctrl exposes a single set
- * of caps per rid.
+ * Pick one BC to back both MB_MIN and MB_WGHT.
  */
 static int cbqri_resctrl_pick_bw_alloc(void)
 {
 	struct cbqri_resctrl_res *mb_min = &cbqri_resctrl_resources[RDT_RESOURCE_MB_MIN];
+	struct cbqri_resctrl_res *mb_wght = &cbqri_resctrl_resources[RDT_RESOURCE_MB_WGHT];
 	struct cbqri_controller *ctrl;
 
 	list_for_each_entry(ctrl, &cbqri_controllers, list) {
@@ -723,6 +768,7 @@ static int cbqri_resctrl_pick_bw_alloc(void)
 		}
 
 		mb_min->ctrl = ctrl;
+		mb_wght->ctrl = ctrl;
 	}
 
 	return 0;
@@ -961,10 +1007,46 @@ static int cbqri_attach_cpu_to_one_bw_res(struct cbqri_controller *ctrl,
 	return 0;
 }
 
+static void cbqri_detach_cpu_from_one_bw_res(struct cbqri_controller *ctrl,
+					     enum resctrl_res_level rid,
+					     unsigned int cpu)
+{
+	struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
+	struct rdt_resource *res = &hw_res->resctrl_res;
+	struct rdt_ctrl_domain *domain;
+	int dom_id = ctrl->mem.prox_dom;
+
+	lockdep_assert_held(&cbqri_domain_list_lock);
+
+	if (!hw_res->ctrl)
+		return;
+
+	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
+	if (!domain || !cpumask_test_cpu(cpu, &domain->hdr.cpu_mask))
+		return;
+
+	cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
+	if (cpumask_empty(&domain->hdr.cpu_mask)) {
+		resctrl_offline_ctrl_domain(res, domain);
+		list_del(&domain->hdr.list);
+		kfree(container_of(domain, struct cbqri_resctrl_dom,
+				   resctrl_ctrl_dom));
+	}
+}
+
 static int cbqri_attach_cpu_to_bw_ctrl(struct cbqri_controller *ctrl,
 				       unsigned int cpu)
 {
-	return cbqri_attach_cpu_to_one_bw_res(ctrl, RDT_RESOURCE_MB_MIN, cpu);
+	int err;
+
+	err = cbqri_attach_cpu_to_one_bw_res(ctrl, RDT_RESOURCE_MB_MIN, cpu);
+	if (err)
+		return err;
+
+	err = cbqri_attach_cpu_to_one_bw_res(ctrl, RDT_RESOURCE_MB_WGHT, cpu);
+	if (err)
+		cbqri_detach_cpu_from_one_bw_res(ctrl, RDT_RESOURCE_MB_MIN, cpu);
+	return err;
 }
 
 static void cbqri_detach_cpu_from_l3_mon(struct rdt_resource *res,

-- 
2.43.0

