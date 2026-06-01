Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C43FCB2F;
	Mon,  1 Jun 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346198; cv=none; b=G2eoGGw2zDFlRAiegqrhCX1XzFo9rlVE9PZeOWEiTbDUwKKoFfv9yp8lhNPMr5WRfUShWLSsfP2fozzoyee9M4IaW4Yxc5RsafiQRcymxZsBqjL8NSKIPGTFAloIba6gczPwsJUx0w9xWKowEoAvcCfUWcrX611iD1Yuhbk4rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346198; c=relaxed/simple;
	bh=Y0XxVCH1oI0OHqCclMlaz+iRYbQWNxAWz1RLz5vRgmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUsVEPYZN6fC2oRibPd3cNlJ+c6YhEZwGt5N9uZXRalB4ReEDTzvcoWkSPs6qMNihjk59cj9yWYWbGi6tjoUsEN8AwG8jJCVcLIA2UyZKQ+KD4pWH5VOeVtu/xm/cLEcS9NC6FHo/mcnigmSj7WbmJcjOt1UArGDxN8gZU0q+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrmdVqpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrmdVqpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976AE1F008A4;
	Mon,  1 Jun 2026 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346195;
	bh=y2Yty5WWEVAqZUasQUaZanbkajp1pIYblaxHbIVHaN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NrmdVqpqp0T5h1EP/WvQlJtucvoJrau7anR4qwEcAPqri0ZjDb5N8Hf9gfsU3F0Dy
	 kOv4lQ9yI9ttICMwMijoZm9uAS0cDqctNpv4YA7zQc/jjqESYG0MYWyVXg2qDlHuxt
	 B0k8xFF4GC5UzTVGCYl5iciaJe7cEcNoGhmmy9x06340Y+jDplfQPfVj7ZzMw2KYdB
	 DoS1LMohmqmYQ28T/uKBpezd3krnJ/PMa4kkNbvQEjxoJODNIYn0C6tDu4qCUN0Z1i
	 sG671mWtxs7QBbJBoRy4j+hYF/tlT9C4ZCL1dd7y/OtJTVtA/IekuenixdG267m2SX
	 MtHnK8jOLl0OA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:09 -0700
Subject: [PATCH RFC v6 15/18] riscv_cbqri: resctrl: Add mbm_total_bytes
 bandwidth monitoring
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-15-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10593; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Y0XxVCH1oI0OHqCclMlaz+iRYbQWNxAWz1RLz5vRgmM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnUxLlNyk3yxZpPxml/yx8+kb1OfyOe+M+ZrN+M5w
 ekdemv9O0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATsTJk+F8/+eC856k3FwtO
 /FNenFK9RqA3QclHa/98hoTG1/wdE5cy/C8qstudYNpe0t10zv4QX0xnzLLAtFK35a8OCYtFPM7
 8wAMA
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
 drivers/resctrl/cbqri_resctrl.c | 232 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
index 14b955eb7949..efd75d241122 100644
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
@@ -184,17 +191,67 @@ void resctrl_arch_mon_event_config_write(void *info)
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
 			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
 {
+	struct cbqri_resctrl_dom *hw_dom;
+	struct rdt_ctrl_domain *cd;
+
+	if (irqs_disabled())
+		return;
+
+	mutex_lock(&cbqri_domain_list_lock);
+
 	/*
 	 * Occupancy MCIDs are armed once by cbqri_init_mon_counters() and
-	 * free run thereafter. The core only reads occupancy on the limbo
-	 * recycle path, never resets it, so there is no per-rmid software
-	 * state to clear here.
+	 * free run thereafter, so only mbm_total_bytes needs a per-rmid reset.
 	 */
+	switch (eventid) {
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
+	default:
+		break;
+	}
+
+	mutex_unlock(&cbqri_domain_list_lock);
 }
 
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
 {
-	/* Occupancy counters free run, so there is no state to reset. */
+	int i;
+
+	/*
+	 * Occupancy counters free run and need no reset; only the
+	 * mbm_total_bytes accumulators are cleared. Bound by max_rmid
+	 * (system-wide minimum mcid_count).
+	 */
+	for (i = 0; i < max_rmid; i++)
+		resctrl_arch_reset_rmid(r, d, 0, i, QOS_L3_MBM_TOTAL_EVENT_ID);
 }
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
@@ -257,6 +314,82 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
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
@@ -773,6 +906,61 @@ static int cbqri_resctrl_pick_bw_alloc(void)
 
 	return 0;
 }
+
+/*
+ * Enable mbm_total_bytes when the system exposes exactly one mon-capable
+ * bandwidth controller and exactly one L3 cache. Pairing a single BC with
+ * multiple L3 domains would let userspace overcount system bandwidth by a
+ * factor equal to the L3 domain count. resctrl_is_mon_event_enabled() then
+ * gates the BC pairing and rmid-space accounting. L3 occupancy is enabled
+ * by cbqri_resctrl_control_init().
+ */
+static void cbqri_resctrl_pick_counters(void)
+{
+	struct cbqri_resctrl_res *l3 = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
+	struct cbqri_controller *ctrl, *prev;
+	unsigned int l3_count = 0;
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
+	/*
+	 * mbm_total_bytes is surfaced on the L3 monitoring domain, so it
+	 * needs a mon-capable L3 cache controller as well as a single
+	 * mon-capable bandwidth controller.
+	 */
+	if (l3->ctrl && l3->ctrl->mon_capable && cbqri_find_only_mon_bc())
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false, 0, NULL);
+}
+
 static void cbqri_resctrl_accumulate_caps(void)
 {
 	struct cbqri_controller *l3_ctrl;
@@ -798,6 +986,18 @@ static void cbqri_resctrl_accumulate_caps(void)
 	if (l3_ctrl && l3_ctrl->mon_capable)
 		max_rmid = min(max_rmid, l3_ctrl->mcid_count);
 
+	/*
+	 * When mbm_total_bytes is enabled, the paired BC is a second counter
+	 * source, so clamp against its mcid_count too. A BC left unpicked
+	 * because mbm_total_bytes is disabled must not clamp it.
+	 */
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
+		struct cbqri_controller *bc = cbqri_find_only_mon_bc();
+
+		if (bc)
+			max_rmid = min(max_rmid, bc->mcid_count);
+	}
+
 	if (!exposed_mon_capable) {
 		max_rmid = 1;
 		return;
@@ -854,6 +1054,7 @@ static int cbqri_attach_cpu_to_l3_mon(struct cbqri_controller *ctrl,
 {
 	struct rdt_l3_mon_domain *mon_dom;
 	struct rdt_ctrl_domain *ctrl_dom;
+	struct cbqri_resctrl_dom *hw_dom;
 	struct list_head *mon_pos = NULL;
 	int dom_id = ctrl->cache.cache_id;
 	int err;
@@ -893,6 +1094,27 @@ static int cbqri_attach_cpu_to_l3_mon(struct cbqri_controller *ctrl,
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
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		hw_dom->paired_bc = cbqri_find_only_mon_bc();
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
@@ -1202,6 +1424,8 @@ static int cbqri_resctrl_setup(void)
 	if (err)
 		return err;
 
+	cbqri_resctrl_pick_counters();
+
 	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
 		err = cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid]);
 		if (err)

-- 
2.43.0

