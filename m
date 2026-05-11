Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB33806BD;
	Mon, 11 May 2026 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476278; cv=none; b=dxkevf0yBnkP6ciknU+DyEBeiYG56hh3RYYnJsBJS19WwGv0eFH8aqbvw9MJzoGCHuQySfoAn2UCgHVB2VKF0BQnKZrVY2zCjRmSA4vzt9hlX2GLxB5zQF3Z15lwFqsFTv+DldDGFJATitzRXl3b+qIB7x4ClSp0Jg3z1ZozqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476278; c=relaxed/simple;
	bh=Fhw3phRjFaNZVnLaZwAKuhmfF7SR2HT1EB37+I5rxEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wh+NoWN/j8z4lDrwJUQewNZ749SlBv/ctwwP7ogZHku9Nv+3Ei2oAnH6JSJKHyUp9P7XKMLYOzXvQ9KqdiG+sc3qfv9aKDjtqCKcFMgfKRiw2I79M1RUSAOYlZllXeMxUe3tENL7Ip1L4PApwJe+5CRtnAKTPhhQjt7p+/tAPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZbzRq0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZbzRq0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF15C2BCF5;
	Mon, 11 May 2026 05:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476278;
	bh=Fhw3phRjFaNZVnLaZwAKuhmfF7SR2HT1EB37+I5rxEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PZbzRq0NwwPStyJl+cRHtd/tV5PYCfoUZ24oYb57XmznoQhbCF4fBAtCnNIpulz0r
	 g/4ZAkAg3nnaOSYQ3xGdmkwoL096tqCjmdULnH2aHu+GvF2BLjhMQkNwBcLD7qj+y6
	 9YQckb1B+Evk3zm9DQ13ypQuyvPkxBm9WkAmaj6ar0iNcF8Rg3nyrg8HeImNGiCkkQ
	 TahNgCwJBKFtaHMKnNq0hSqI51OXdIUnjbHd+OGRPPNZh8kEtSLc6t3grMEJ5vAXRc
	 py+QLtR4yHKyPgKOxmfcmx71fNHPjfkgfjCY209EJnws9/OiW2dDFuJ4WEdmSg91N8
	 sAEt5JrfoCQIg==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:10 -0700
Subject: [PATCH RFC v4 14/18] riscv_cbqri: resctrl: Add MB_WGHT bandwidth
 allocation via Mweight
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-14-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5399; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Fhw3phRjFaNZVnLaZwAKuhmfF7SR2HT1EB37+I5rxEI=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprz+xGVk35e87I8SO4/Vx3Qp1QOLq79Mv8KxZZZOQ
 GImz/ZdHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJrNzF8L9wgsBybq2knOWb
 fsWqnlIQ25ltudfAYv+bvop5G7wUzNQYGZZ+ip36MPPeQaUbhwNkD7N+fR9ZnRWZzbyN6VrC7Qv
 WSmwA
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
 drivers/resctrl/cbqri_resctrl.c | 62 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index bcd9367e3555..71ee8e610757 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -418,6 +418,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	case RDT_RESOURCE_MB_MIN:
 		/* sum(Rbwb) <= MRBWB validation runs inside cbqri_apply_rbwb(). */
 		return cbqri_apply_rbwb(dom->hw_ctrl, closid, cfg_val, true);
+	case RDT_RESOURCE_MB_WGHT:
+		return cbqri_apply_mweight_config(dom->hw_ctrl, closid, cfg_val);
 	default:
 		return -EINVAL;
 	}
@@ -478,6 +480,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
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
@@ -526,6 +536,18 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
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
@@ -594,6 +616,11 @@ static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_dom
 			err = cbqri_apply_rbwb(dom->hw_ctrl, rcid, rbwb, false);
 			break;
 		}
+		case RDT_RESOURCE_MB_WGHT:
+			/* Match the new-group default: equal weights across RCIDs. */
+			err = cbqri_apply_mweight_config(dom->hw_ctrl, i,
+							 resctrl_get_default_ctrl(r));
+			break;
 		default:
 			/*
 			 * Seed both DATA and CODE staged slots so a later
@@ -731,6 +758,25 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
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
+		 * default_to_min false: groups default to max_bw.
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
@@ -739,13 +785,14 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 }
 
 /*
- * Pick one BC to back MB_MIN.  Multiple BCs must agree on rcid_count
- * and mrbwb.  Mismatch is fatal because resctrl exposes a single set
- * of caps per rid.
+ * Pick one BC to back both MB_MIN and MB_WGHT (they share a controller).
+ * Multiple BCs must agree on rcid_count and mrbwb. Mismatch is fatal
+ * because resctrl exposes a single set of caps per rid.
  */
 static int cbqri_resctrl_pick_bw_alloc(void)
 {
 	struct cbqri_resctrl_res *mb_min = &cbqri_resctrl_resources[RDT_RESOURCE_MB_MIN];
+	struct cbqri_resctrl_res *mb_wght = &cbqri_resctrl_resources[RDT_RESOURCE_MB_WGHT];
 	struct cbqri_controller *ctrl;
 
 	list_for_each_entry(ctrl, &cbqri_controllers, list) {
@@ -764,6 +811,7 @@ static int cbqri_resctrl_pick_bw_alloc(void)
 		}
 
 		mb_min->ctrl = ctrl;
+		mb_wght->ctrl = ctrl;
 	}
 
 	return 0;
@@ -982,7 +1030,13 @@ static int cbqri_attach_cpu_to_one_bw_res(struct cbqri_controller *ctrl,
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
+	return cbqri_attach_cpu_to_one_bw_res(ctrl, RDT_RESOURCE_MB_WGHT, cpu);
 }
 
 static void cbqri_detach_cpu_from_l3_mon(struct rdt_resource *res,

-- 
2.43.0

