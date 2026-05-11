Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5E3783DB;
	Mon, 11 May 2026 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476277; cv=none; b=AtJdEgPB8MWHsrjxZXbRRXnVU2pYxbp3VwB040KkNlC9VcuSthD6kZf4C84zzM/mcXL3AGXKmhTi5qPX3ePjj/eL3WFtQOpBAXTA+xo7zXD3JsIisVOLA14OirQV3GDvGxusycNBlNItIC4JBK5OxUYtARiid6s2sGKWnDJ39uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476277; c=relaxed/simple;
	bh=7ajHHusmr2SQHtDoK/9t3UbHHQwh8nmBa8tMo8RCQEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/2p3J8YTu4GAmzk3H8Z1aF8HSRfUzXt8GXb/fXqcGXFmumn5k951x+WZYJkM8mjma+Xm7OiQxZfjPnuF4P/AVDUdxmN3c+ib4iDUHWw7l/eD8DptiyHjhVnCSr00jIhcKSGnJ/YQVQCKIgfrKJjB1ULDpjp2xUGoPYu37av3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIgdrtzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIgdrtzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4986C2BCF5;
	Mon, 11 May 2026 05:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476277;
	bh=7ajHHusmr2SQHtDoK/9t3UbHHQwh8nmBa8tMo8RCQEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bIgdrtzBLsW5vmOqOpexKbcFWAUbx3l8MoGhRo1Gd8sK4y8+w37EAzcvOrslIKNZk
	 JHfxJSORgjVBCuRMYoNG4GeNASwwsPjsLXWBiHLxlwMWSUqgBIYskiB6gtH+H+b+e+
	 9IFFqmcG73FA5313L01vdnZpdheRLchYUm7JbjdB+N70vGN/CJO4CwnGodZaLcY/5y
	 wvrFeL2IeubraFF60NKuUa7mGI1qGBPcTm63Suk4reIu2A1049JMGZfuxoGZgPF7Bh
	 XvjXTLU3+0ZhXTeWSKiUhrTJEdjBdseuv9Fo7lrzJeMLE7eqAvFNrc/zE5XuEyjPG6
	 zscnLj4k+ri0g==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:08 -0700
Subject: [PATCH RFC v4 12/18] riscv_cbqri: resctrl: Add L3 cache occupancy
 monitoring
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-12-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13782; i=fustini@kernel.org;
 h=from:subject:message-id; bh=7ajHHusmr2SQHtDoK/9t3UbHHQwh8nmBa8tMo8RCQEk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprxOPPiHw0byzJHln5V+sb8QfBw0X1g6f8ddG4H+e
 R3f89tEO0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQAT8TNm+GcrGRIyiW9uh72c
 16toTS+pj4/nLehY5+pi+WSvxJYNG+IZGbbX/OLznP8/efPz+T8V5GZdEb65V+3xpeMStU9X1lb
 YezIBAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Expose QOS_L3_OCCUP_EVENT_ID so userspace can read per-MCID
llc_occupancy. The result is converted from capacity blocks to bytes
using cache_size and ncblks.

resctrl_arch_reset_rmid() re-arms CONFIG_EVENT with EVT_ID=Occupancy.
CONFIG_EVENT both resets the counter to 0 and selects the event, so
re-arming with the same event keeps the MCID counting after reset rather
than relying on sticky-last-event semantics that the CBQRI register
definition does not guarantee.

The L3 mon_domain is created lazily on the first CPU of a cache_id and
linked to the paired ctrl_domain.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 272 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 260 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index 82b157d35576..d8fd9b06703f 100644
--- a/drivers/resctrl/cbqri_resctrl.c
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -10,6 +10,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/resctrl.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -33,6 +34,13 @@ struct cbqri_resctrl_dom {
 
 static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
 
+/*
+ * Per-event controller table. Only events CBQRI can back occupy a
+ * slot, so other events do not bloat the array.
+ */
+#define CBQRI_MAX_EVENT QOS_L3_OCCUP_EVENT_ID
+static struct cbqri_controller *cbqri_resctrl_counters[CBQRI_MAX_EVENT + 1];
+
 /*
  * cacheinfo populates the cache id <-> cpumask mapping from a
  * device_initcall(). cbqri_resctrl_setup() runs at late_initcall, which
@@ -44,6 +52,10 @@ static bool cacheinfo_ready;
 static DECLARE_WAIT_QUEUE_HEAD(wait_cacheinfo_ready);
 
 static bool exposed_alloc_capable;
+static bool exposed_mon_capable;
+
+/* Used by resctrl_arch_system_num_rmid_idx(). Narrowed by accumulate_caps. */
+static u32 max_rmid = U32_MAX;
 
 /* Protects ctrl_domain list mutations across CPU hotplug. */
 static DEFINE_MUTEX(cbqri_domain_list_lock);
@@ -56,6 +68,14 @@ cbqri_find_ctrl_domain(struct list_head *h, int id)
 	return hdr ? container_of(hdr, struct rdt_ctrl_domain, hdr) : NULL;
 }
 
+static struct rdt_l3_mon_domain *
+cbqri_find_l3_mon_domain(struct list_head *h, int id)
+{
+	struct rdt_domain_hdr *hdr = resctrl_find_domain(h, id, NULL);
+
+	return hdr ? container_of(hdr, struct rdt_l3_mon_domain, hdr) : NULL;
+}
+
 /*
  * Resctrl-side wrapper around the device-side cbqri_apply_cache_config().
  * Builds the hardware config struct from resctrl-side state (cdp flag, AT
@@ -84,7 +104,7 @@ bool resctrl_arch_alloc_capable(void)
 
 bool resctrl_arch_mon_capable(void)
 {
-	return false;
+	return exposed_mon_capable;
 }
 
 bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
@@ -185,20 +205,112 @@ void resctrl_arch_mon_event_config_write(void *info)
 {
 }
 
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
 {
+	struct cbqri_resctrl_dom *hw_dom;
+	struct cbqri_controller *ctrl;
+	struct rdt_ctrl_domain *cd;
+
+	/* Don't sleep with IRQs disabled. */
+	if (irqs_disabled())
+		return;
+
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		cd = cbqri_find_ctrl_domain(&r->ctrl_domains, d->hdr.id);
+		if (!cd)
+			return;
+
+		hw_dom = container_of(cd, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		ctrl = hw_dom->hw_ctrl;
+
+		mutex_lock(&ctrl->lock);
+		/*
+		 * Re-arm with EVT_ID=OCCUPANCY (not None) on RMID recycle:
+		 * this both zeros the counter and keeps the MCID counting,
+		 * since cbqri_init_mon_counters() only runs once.
+		 */
+		if (cbqri_mon_op(ctrl, CBQRI_CC_MON_CTL_OFF,
+				 CBQRI_CC_MON_CTL_OP_CONFIG_EVENT,
+				 rmid, CBQRI_CC_EVT_ID_OCCUPANCY, NULL))
+			pr_warn_ratelimited("CC@%pa MCID %u: occupancy reset failed\n",
+					    &ctrl->addr, rmid);
+		mutex_unlock(&ctrl->lock);
+		return;
+
+	default:
+		return;
+	}
 }
 
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
-			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
 {
+	int i;
+
+	/* Bound by max_rmid (system-wide minimum mcid_count). */
+	for (i = 0; i < max_rmid; i++)
+		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_OCCUP_EVENT_ID);
 }
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   void *arch_priv, u64 *val, void *arch_mon_ctx)
 {
-	return -ENODATA;
+	struct cbqri_resctrl_dom *hw_dom;
+	struct cbqri_controller *ctrl;
+	struct rdt_ctrl_domain *d;
+	u64 ctr_val;
+	int err;
+
+	resctrl_arch_rmid_read_context_check();
+
+	/*
+	 * Each branch takes a sleeping mutex. Bail if called with IRQs
+	 * disabled (e.g. smp_call_function_any() from nohz_full CPUs).
+	 */
+	if (irqs_disabled())
+		return -EIO;
+
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		/* Mon domain id matches the ctrl_domain id. Look up to get hw_ctrl. */
+		d = cbqri_find_ctrl_domain(&r->ctrl_domains, hdr->id);
+		if (!d)
+			return -ENOENT;
+
+		hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		ctrl = hw_dom->hw_ctrl;
+
+		mutex_lock(&ctrl->lock);
+
+		/*
+		 * MCIDs are armed with Occupancy at init and re-armed on
+		 * RMID recycle. Pass EVT_ID explicitly: the CBQRI spec
+		 * does not guarantee sticky-last-configured-event for
+		 * READ_COUNTER.
+		 */
+		err = cbqri_mon_op(ctrl, CBQRI_CC_MON_CTL_OFF,
+				   CBQRI_CC_MON_CTL_OP_READ_COUNTER,
+				   rmid, CBQRI_CC_EVT_ID_OCCUPANCY, NULL);
+		if (err)
+			goto out_cc;
+
+		ctr_val = ioread64(ctrl->base + CBQRI_CC_MON_CTL_VAL_OFF);
+
+		/*
+		 * Capacity blocks to bytes. Multiply before divide so a
+		 * non-power-of-2 ncblks doesn't truncate. Both terms fit
+		 * in u64 with room to spare.
+		 */
+		*val = (u64)ctrl->cache.cache_size * ctr_val / ctrl->cc.ncblks;
+out_cc:
+		mutex_unlock(&ctrl->lock);
+		return err;
+
+	default:
+		return -EINVAL;
+	}
 }
 
 /*
@@ -225,7 +337,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
 
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	return 1;
+	return max_rmid;
 }
 
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
@@ -517,6 +629,14 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 		res->alloc_capable = ctrl->alloc_capable;
 		INIT_LIST_HEAD(&res->ctrl_domains);
 		INIT_LIST_HEAD(&res->mon_domains);
+
+		if (ctrl->mon_capable && res->rid == RDT_RESOURCE_L3) {
+			res->mon_scope = RESCTRL_L3_CACHE;
+			res->mon.num_rmid = ctrl->mcid_count;
+			resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID,
+						 false, 0, NULL);
+			res->mon_capable = true;
+		}
 		break;
 	default:
 		break;
@@ -525,8 +645,21 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 	return 0;
 }
 
+/*
+ * Pick one controller per monitoring event.  L3 OCCUP comes from the
+ * picked L3 CC (if mon_capable).
+ */
+static void cbqri_resctrl_pick_counters(void)
+{
+	struct cbqri_resctrl_res *l3 = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
+
+	if (l3->ctrl && l3->ctrl->mon_capable)
+		cbqri_resctrl_counters[QOS_L3_OCCUP_EVENT_ID] = l3->ctrl;
+}
+
 static void cbqri_resctrl_accumulate_caps(void)
 {
+	struct cbqri_controller *ctrl;
 	int rid;
 
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
@@ -536,7 +669,22 @@ static void cbqri_resctrl_accumulate_caps(void)
 			continue;
 		if (hw_res->ctrl->alloc_capable)
 			exposed_alloc_capable = true;
+		if (hw_res->ctrl->mon_capable)
+			exposed_mon_capable = true;
 	}
+
+	/*
+	 * Narrow max_rmid against mon-capable controllers only. RQSC may
+	 * report mcid_count for non-mon-capable ones. Clamping the global
+	 * minimum against those would shrink the rmid space unnecessarily.
+	 */
+	list_for_each_entry(ctrl, &cbqri_controllers, list)
+		if (ctrl->mon_capable)
+			max_rmid = min(max_rmid, ctrl->mcid_count);
+
+	/* No mon-capable controller picked: leave max_rmid sentinel-narrowed. */
+	if (!exposed_mon_capable)
+		max_rmid = 1;
 }
 
 /*
@@ -577,6 +725,71 @@ static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller
 	return domain;
 }
 
+static int cbqri_attach_cpu_to_l3_mon(struct cbqri_controller *ctrl,
+				      struct rdt_resource *res, unsigned int cpu)
+{
+	struct rdt_l3_mon_domain *mon_dom;
+	struct rdt_ctrl_domain *ctrl_dom;
+	struct list_head *mon_pos = NULL;
+	int dom_id = ctrl->cache.cache_id;
+	int err;
+
+	lockdep_assert_held(&cbqri_domain_list_lock);
+
+	mon_dom = cbqri_find_l3_mon_domain(&res->mon_domains, dom_id);
+	if (mon_dom) {
+		cpumask_set_cpu(cpu, &mon_dom->hdr.cpu_mask);
+		return 0;
+	}
+
+	ctrl_dom = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
+	if (!ctrl_dom) {
+		pr_err("L3 mon attach for cpu %u: no ctrl_domain id %d\n",
+		       cpu, dom_id);
+		return -EINVAL;
+	}
+
+	mon_dom = kzalloc_obj(*mon_dom, GFP_KERNEL);
+	if (!mon_dom)
+		return -ENOMEM;
+
+	mon_dom->hdr.id = dom_id;
+	mon_dom->hdr.type = RESCTRL_MON_DOMAIN;
+	mon_dom->hdr.rid = RDT_RESOURCE_L3;
+	cpumask_set_cpu(cpu, &mon_dom->hdr.cpu_mask);
+	INIT_LIST_HEAD(&mon_dom->hdr.list);
+
+	if (resctrl_find_domain(&res->mon_domains, dom_id, &mon_pos)) {
+		pr_err("duplicate L3 mon_domain id %d\n", dom_id);
+		err = -EEXIST;
+		goto err_free;
+	}
+	if (mon_pos)
+		list_add_tail(&mon_dom->hdr.list, mon_pos);
+	else
+		list_add_tail(&mon_dom->hdr.list, &res->mon_domains);
+
+	err = resctrl_online_mon_domain(res, &mon_dom->hdr);
+	if (err)
+		goto err_listdel;
+
+	err = cbqri_init_mon_counters(ctrl);
+	if (err)
+		goto err_offline;
+
+	return 0;
+
+err_offline:
+	cancel_delayed_work_sync(&mon_dom->cqm_limbo);
+	cancel_delayed_work_sync(&mon_dom->mbm_over);
+	resctrl_offline_mon_domain(res, &mon_dom->hdr);
+err_listdel:
+	list_del(&mon_dom->hdr.list);
+err_free:
+	kfree(mon_dom);
+	return err;
+}
+
 static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 					unsigned int cpu)
 {
@@ -584,6 +797,7 @@ static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 	struct rdt_ctrl_domain *domain;
 	struct rdt_resource *res;
 	int dom_id;
+	int err;
 
 	if (ctrl->cache.cache_level == 2)
 		hw_res = &cbqri_resctrl_resources[RDT_RESOURCE_L2];
@@ -601,16 +815,42 @@ static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
 	if (domain) {
 		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
-		return 0;
+	} else {
+		domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
+		if (IS_ERR(domain))
+			return PTR_ERR(domain);
 	}
 
-	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
-	if (IS_ERR(domain))
-		return PTR_ERR(domain);
+	if (ctrl->mon_capable && ctrl->cache.cache_level == 3) {
+		err = cbqri_attach_cpu_to_l3_mon(ctrl, res, cpu);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
 
+static void cbqri_detach_cpu_from_l3_mon(struct rdt_resource *res,
+					 unsigned int cpu)
+{
+	struct rdt_l3_mon_domain *mon_dom, *tmp;
+
+	lockdep_assert_held(&cbqri_domain_list_lock);
+
+	list_for_each_entry_safe(mon_dom, tmp, &res->mon_domains, hdr.list) {
+		if (!cpumask_test_cpu(cpu, &mon_dom->hdr.cpu_mask))
+			continue;
+		cpumask_clear_cpu(cpu, &mon_dom->hdr.cpu_mask);
+		if (cpumask_empty(&mon_dom->hdr.cpu_mask)) {
+			cancel_delayed_work_sync(&mon_dom->cqm_limbo);
+			cancel_delayed_work_sync(&mon_dom->mbm_over);
+			resctrl_offline_mon_domain(res, &mon_dom->hdr);
+			list_del(&mon_dom->hdr.list);
+			kfree(mon_dom);
+		}
+	}
+}
+
 static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
 					       unsigned int cpu)
 {
@@ -634,7 +874,7 @@ static bool cbqri_resctrl_inited;
 
 static void cbqri_resctrl_teardown(void)
 {
-	int rid;
+	int rid, evt;
 
 	if (!cbqri_resctrl_inited)
 		return;
@@ -647,7 +887,11 @@ static void cbqri_resctrl_teardown(void)
 		hw_res->ctrl = NULL;
 		hw_res->cdp_enabled = false;
 	}
+	for (evt = 0; evt <= CBQRI_MAX_EVENT; evt++)
+		cbqri_resctrl_counters[evt] = NULL;
 	exposed_alloc_capable = false;
+	exposed_mon_capable = false;
+	max_rmid = U32_MAX;
 	cbqri_resctrl_inited = false;
 }
 
@@ -666,6 +910,8 @@ static int cbqri_resctrl_setup(void)
 	if (err)
 		return err;
 
+	cbqri_resctrl_pick_counters();
+
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
 		err = cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid]);
 		if (err)
@@ -674,7 +920,7 @@ static int cbqri_resctrl_setup(void)
 
 	cbqri_resctrl_accumulate_caps();
 
-	if (!exposed_alloc_capable) {
+	if (!exposed_alloc_capable && !exposed_mon_capable) {
 		pr_debug("no resctrl-capable CBQRI controllers found\n");
 		return -ENODEV;
 	}
@@ -723,6 +969,8 @@ static int cbqri_resctrl_offline_cpu(unsigned int cpu)
 		if (!hw_res->ctrl)
 			continue;
 		cbqri_detach_cpu_from_ctrl_domains(&hw_res->resctrl_res, cpu);
+		if (rid == RDT_RESOURCE_L3 && hw_res->ctrl->mon_capable)
+			cbqri_detach_cpu_from_l3_mon(&hw_res->resctrl_res, cpu);
 	}
 
 	mutex_unlock(&cbqri_domain_list_lock);

-- 
2.43.0

