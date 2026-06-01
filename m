Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B73F65E0;
	Mon,  1 Jun 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346194; cv=none; b=RTfDDPMdYJGXbBbntuUCOGcyyWTiJpRMP2O8Z/ZtoWpZKHzBZVFOrGAlQabTuPGbVZXWWBalqmAvl1SdyidJXBzdS4dkbfiUzZAUNyu8MqV35aAjjjtWQgK+qArWLiCUzwLJrDcgyIi+FOY4vWcmNsmx1CC1m+XGov3h9/dlfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346194; c=relaxed/simple;
	bh=TDq5aUaYu2V9OHkOb5NqMyBoroO1Wj/vn9YtYWOCSsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBRTPBxe/BnJf619Ooz5Ikfdb1JCZFK+fJz3846K6I0L+5alvMBU6zPeKQvBDMpVI55KQnh0CIvLYVHcgAmNNgl++xHmExPYuRc/+iqWtdKSkE9W1AOGO+n9pu4Ox5hGA6PWg5hexyKts3rxRF5jLMl9VnOaoiAd3gVGKWcQhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqFDzxu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqFDzxu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5CC1F00A01;
	Mon,  1 Jun 2026 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346192;
	bh=ExeO4pgSdUF010kVTEBC1O84msec/XDSsHQ4MfdpSGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FqFDzxu7/T6I/uNql61JLjy4BfB6zGAOoNv/ctgfNBiz+g6DHsWpVod0lplC381sf
	 imIl3y3+XbBwuwzpJ9FYlWcy9AG+wDbOLzk+Qz7PinbZTi0yNDKxs/a+TcNA0GiDlB
	 pj4YtMG9Gvj7mgzkwy8HSYzf+MaONfxnU5QCw/2qxpNdujc2YMmYCmaPyVM2uBpV2f
	 fTbHlrx8ef2SCMf8hwfeEiEtAlD+iQkQQSTuNrTCOUqSH7J4MxYj28i9BmyZPm5VI8
	 SINC0/OLt1FQal9AlGxDCbGWsWV2VBOys329Iv2oz38Xt9HSvuKHvwg08iljPsBkBB
	 uTgeUZFWKOBgA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:06 -0700
Subject: [PATCH RFC v6 12/18] riscv_cbqri: resctrl: Add L3 cache occupancy
 monitoring
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-12-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13890; i=fustini@kernel.org;
 h=from:subject:message-id; bh=TDq5aUaYu2V9OHkOb5NqMyBoroO1Wj/vn9YtYWOCSsg=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnVW35gqpBebwGWSOXmp6qIJBse9kvju3H38oo2Xa
 clp7vO8HaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJiPoxMjzsmeu8bx+D6JYe
 3r2sepK2V6caLp+c3HtCKfd56PwFpi6MDBtdnN6HX9wcmi8X873A7smDG85F56+31xT/3LaochF
 DNg8A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Expose QOS_L3_OCCUP_EVENT_ID so userspace can read per-MCID
llc_occupancy. The result is converted from capacity blocks to bytes
using cache_size and ncblks.

Each MCID is armed once with the Occupancy event by
cbqri_init_mon_counters() and free runs thereafter. The resctrl core
only reads occupancy on the limbo recycle path and never resets it, so
resctrl_arch_reset_rmid() and resctrl_arch_reset_rmid_all() have no
per-rmid software state to clear.

The L3 mon_domain is created lazily on the first CPU of a cache_id and
linked to the paired ctrl_domain.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_resctrl.c | 286 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 274 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index fb6d82aa3ffc..f379058b0114 100644
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
@@ -33,6 +34,10 @@ struct cbqri_resctrl_dom {
 static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
 
 static bool exposed_alloc_capable;
+static bool exposed_mon_capable;
+
+/* Used by resctrl_arch_system_num_rmid_idx(). Narrowed by accumulate_caps. */
+static u32 max_rmid = U32_MAX;
 
 /* Protects ctrl_domain list mutations across CPU hotplug. */
 static DEFINE_MUTEX(cbqri_domain_list_lock);
@@ -45,6 +50,14 @@ cbqri_find_ctrl_domain(struct list_head *h, int id)
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
 static int cbqri_apply_cache_config_dom(struct cbqri_resctrl_dom *hw_dom,
 					struct rdt_resource *r,
 					u32 closid, enum resctrl_conf_type t,
@@ -68,7 +81,7 @@ bool resctrl_arch_alloc_capable(void)
 
 bool resctrl_arch_mon_capable(void)
 {
-	return false;
+	return exposed_mon_capable;
 }
 
 bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
@@ -168,20 +181,89 @@ void resctrl_arch_mon_event_config_write(void *info)
 {
 }
 
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
 {
+	/*
+	 * Occupancy MCIDs are armed once by cbqri_init_mon_counters() and
+	 * free run thereafter. The core only reads occupancy on the limbo
+	 * recycle path, never resets it, so there is no per-rmid software
+	 * state to clear here.
+	 */
 }
 
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
-			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
 {
+	/* Occupancy counters free run, so there is no state to reset. */
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
+	int err = 0;
+
+	resctrl_arch_rmid_read_context_check();
+
+	/*
+	 * cbqri_mon_op() takes ctrl->lock sleeping mutex and polls
+	 * BUSY for up to 1 ms, neither of which is safe under
+	 * irqs_disabled().
+	 */
+	if (irqs_disabled())
+		return -EIO;
+
+	/*
+	 * cbqri_domain_list_lock serialises the list walk against
+	 * cbqri_detach_cpu_from_ctrl_domains().
+	 */
+	mutex_lock(&cbqri_domain_list_lock);
+
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		d = cbqri_find_ctrl_domain(&r->ctrl_domains, hdr->id);
+		if (!d) {
+			err = -ENOENT;
+			break;
+		}
+
+		hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+		ctrl = hw_dom->hw_ctrl;
+
+		mutex_lock(&ctrl->lock);
+
+		/*
+		 * MCIDs are armed with Occupancy once at init and free run.
+		 * Pass EVT_ID explicitly as the CBQRI spec does not guarantee
+		 * sticky-last-configured-event for READ_COUNTER.
+		 */
+		err = cbqri_mon_op(ctrl, CBQRI_CC_MON_CTL_OFF,
+				   CBQRI_CC_MON_CTL_OP_READ_COUNTER,
+				   rmid, CBQRI_CC_EVT_ID_OCCUPANCY, NULL);
+		if (!err) {
+			ctr_val = ioread64(ctrl->base + CBQRI_CC_MON_CTL_VAL_OFF);
+
+			/*
+			 * Capacity blocks to bytes. Multiply before divide
+			 * so a non-power-of-2 ncblks doesn't truncate.
+			 */
+			*val = (u64)ctrl->cache.cache_size * ctr_val /
+			       ctrl->cc.ncblks;
+		}
+		mutex_unlock(&ctrl->lock);
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&cbqri_domain_list_lock);
+	return err;
 }
 
 /*
@@ -203,7 +285,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
 
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	return 1;
+	return max_rmid;
 }
 
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
@@ -500,6 +582,13 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 		res->alloc_capable = ctrl->alloc_capable;
 		INIT_LIST_HEAD(&res->ctrl_domains);
 		INIT_LIST_HEAD(&res->mon_domains);
+
+		if (ctrl->mon_capable && res->rid == RDT_RESOURCE_L3) {
+			res->mon_scope = RESCTRL_L3_CACHE;
+			resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID,
+						 false, 0, NULL);
+			res->mon_capable = true;
+		}
 		break;
 	default:
 		break;
@@ -510,6 +599,7 @@ static int cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
 
 static void cbqri_resctrl_accumulate_caps(void)
 {
+	struct cbqri_controller *l3_ctrl;
 	int rid;
 
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
@@ -519,7 +609,30 @@ static void cbqri_resctrl_accumulate_caps(void)
 			continue;
 		if (hw_res->ctrl->alloc_capable)
 			exposed_alloc_capable = true;
+		if (hw_res->ctrl->mon_capable)
+			exposed_mon_capable = true;
+	}
+
+	/*
+	 * Narrow max_rmid against the picked occupancy source (the L3 CC)
+	 * only. A mon-capable controller that is not exposed as a counter
+	 * source must not clamp the rmid space.
+	 */
+	l3_ctrl = cbqri_resctrl_resources[RDT_RESOURCE_L3].ctrl;
+	if (l3_ctrl && l3_ctrl->mon_capable)
+		max_rmid = min(max_rmid, l3_ctrl->mcid_count);
+
+	if (!exposed_mon_capable) {
+		max_rmid = 1;
+		return;
 	}
+
+	/*
+	 * num_rmid is the user-visible bound for the L3 monitoring rmid
+	 * space. Track max_rmid (the picked-source minimum) so userspace is
+	 * not told more RMIDs than can be allocated.
+	 */
+	cbqri_resctrl_resources[RDT_RESOURCE_L3].resctrl_res.mon.num_rmid = max_rmid;
 }
 
 /*
@@ -560,13 +673,89 @@ static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller
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
+	/*
+	 * cancel_delayed_work avoids deadlocking against the cqm_limbo
+	 * worker which takes cpus_read_lock while this hotplug callback
+	 * already holds cpus_write_lock. mbm_over is only
+	 * INIT_DELAYED_WORK'd when MBM_TOTAL was enabled, so gate the
+	 * cancel on the same condition to avoid touching a zeroed work
+	 * struct.
+	 */
+	cancel_delayed_work(&mon_dom->cqm_limbo);
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		cancel_delayed_work(&mon_dom->mbm_over);
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
 	struct cbqri_resctrl_res *hw_res;
 	struct rdt_ctrl_domain *domain;
 	struct rdt_resource *res;
+	bool new_domain = false;
 	int dom_id;
+	int err;
 
 	if (ctrl->cache.cache_level == 2)
 		hw_res = &cbqri_resctrl_resources[RDT_RESOURCE_L2];
@@ -584,14 +773,68 @@ static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
 	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
 	if (domain) {
 		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
-		return 0;
+	} else {
+		domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
+		if (IS_ERR(domain))
+			return PTR_ERR(domain);
+		new_domain = true;
 	}
 
-	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
-	if (IS_ERR(domain))
-		return PTR_ERR(domain);
+	if (ctrl->mon_capable && ctrl->cache.cache_level == 3) {
+		err = cbqri_attach_cpu_to_l3_mon(ctrl, res, cpu);
+		if (err)
+			goto err_undo_ctrl_dom;
+	}
 
 	return 0;
+
+err_undo_ctrl_dom:
+	/*
+	 * The cpuhp core only rolls back states that successfully ran their
+	 * startup. The L3 mon attach failure happens inside this state's
+	 * startup, so its own offline callback is not invoked. Undo the
+	 * cpumask_set and, if this attach created the ctrl_domain, tear it
+	 * down so a retry sees a clean slate.
+	 */
+	cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
+	if (new_domain) {
+		resctrl_offline_ctrl_domain(res, domain);
+		list_del(&domain->hdr.list);
+		kfree(container_of(domain, struct cbqri_resctrl_dom,
+				   resctrl_ctrl_dom));
+	}
+	return err;
+}
+
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
+			/*
+			 * This runs as a cpuhp offline callback under
+			 * cpus_write_lock. The cqm_limbo and mbm_over workers
+			 * take cpus_read_lock before touching a domain, so
+			 * neither can run or re-queue here. A non-sync cancel
+			 * thus reliably dequeues any pending work before kfree,
+			 * and cancel_delayed_work_sync() would instead deadlock
+			 * against that cpus_read_lock.
+			 */
+			cancel_delayed_work(&mon_dom->cqm_limbo);
+			if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+				cancel_delayed_work(&mon_dom->mbm_over);
+			resctrl_offline_mon_domain(res, &mon_dom->hdr);
+			list_del(&mon_dom->hdr.list);
+			kfree(mon_dom);
+		}
+	}
 }
 
 static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
@@ -630,6 +873,8 @@ static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
 		if (!hw_res->ctrl)
 			continue;
 		cbqri_detach_cpu_from_ctrl_domains(&hw_res->resctrl_res, cpu);
+		if (rid == RDT_RESOURCE_L3 && hw_res->ctrl->mon_capable)
+			cbqri_detach_cpu_from_l3_mon(&hw_res->resctrl_res, cpu);
 	}
 }
 
@@ -683,6 +928,8 @@ static void cbqri_resctrl_teardown(void)
 		hw_res->cdp_enabled = false;
 	}
 	exposed_alloc_capable = false;
+	exposed_mon_capable = false;
+	max_rmid = U32_MAX;
 	cbqri_resctrl_inited = false;
 }
 
@@ -706,14 +953,29 @@ static int cbqri_resctrl_setup(void)
 
 	cbqri_resctrl_accumulate_caps();
 
-	if (!exposed_alloc_capable) {
+	if (!exposed_alloc_capable && !exposed_mon_capable) {
 		pr_debug("no resctrl-capable CBQRI controllers found\n");
 		return -ENODEV;
 	}
 
 	err = resctrl_init();
-	if (err)
+	if (err) {
+		/*
+		 * resctrl_init() failed before we set cbqri_resctrl_inited,
+		 * so cbqri_resctrl_teardown() would no-op. Roll back the
+		 * exposed_*_capable flags and the resource picks directly
+		 * so resctrl_arch_alloc_capable() / _mon_capable() do not
+		 * lie to callers after this returns.
+		 */
+		for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
+			cbqri_resctrl_resources[rid].ctrl = NULL;
+			cbqri_resctrl_resources[rid].cdp_enabled = false;
+		}
+		exposed_alloc_capable = false;
+		exposed_mon_capable = false;
+		max_rmid = U32_MAX;
 		return err;
+	}
 
 	cbqri_resctrl_inited = true;
 	return 0;

-- 
2.43.0

