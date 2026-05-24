Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66D3B8409;
	Sun, 24 May 2026 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667066; cv=none; b=CY0AfdbX695IE5+MSpzhD4aYcs45IF92Zlz+kGg6Ce4hxQKb8oNAoi8q8nDF8qLtEH2pIUlVU6LHMtJ0xBY/UgJDxO10hIYQzkVlPY6raEZDbLB7nyLB8nd3+i4UBhzTLVB4K+oZJNO0JaqTrKdDnUEtbtU1MdBAOHXHoruI/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667066; c=relaxed/simple;
	bh=mUHa6+F/DHq9sHhd8mDFGHM5sAfkWDnb2VjA6lAzldE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4+dL9BQBNhLUAJVkpvV+LE+EsqtUOGJbleKBtHwAnXnub4etZYWtx82MtFVLyyMnxuzlltRh9YVdQZFvRC/sGQQspsJfHO6YRTnLVy50B0ew1oeWNuvXDb7p4rNHSJeQ5B73gnRlIoqksU8xcncyXastafh1E8bfUQTK7TVoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrASOuls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrASOuls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39C41F01561;
	Sun, 24 May 2026 23:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667058;
	bh=4cYMXP3oZ3Td10zGhSlxPHc2jDAhuHwiTxCNtEO8XOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YrASOulssRaEjYkhRuF+kyO/mfkF662TfZwFMDZ4WR5xYt/PT5nOV8+LdgofSgF1n
	 oKAFldrlbWT1WLPk6ZN2Ne6WTCPzkOHrnmnLZQDf/d26sZhI0aj5x5OpGKFSfeeBm6
	 xv+SanoWFyWZKeczZBPQdKnjlvqkd3lH1fpGwreD2O1A5a/MK9x2DKzTjNcVZ0xbNU
	 tWYPnszTnyzAs6e2kkPGHUPmoMq4JezAth8SWh0oqzbLtGWniuxvNjdnl3tAwk/EQd
	 0cAD6maEVCpfo5IVHup9COffqz1O534LWwN+1L+OBsWrxE3D24aqWAx6YKiwhE9ixF
	 /MX+dGxBK9TKA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:40 -0700
Subject: [PATCH RFC v5 10/18] riscv_cbqri: Add bandwidth controller
 monitoring device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-10-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7064; i=fustini@kernel.org;
 h=from:subject:message-id; bh=mUHa6+F/DHq9sHhd8mDFGHM5sAfkWDnb2VjA6lAzldE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8jsWRV84zf3dvdzuq9fTT0571f4/N2ZV+wF9xqv5
 b/BbXh0R0cpC4MYF4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgIgabGP7wimXn1jkatci+
 VAsvl4q9/1yxfOebfW91LUOe6vnqFvxj+B/k7xbyoYfJ5XrK3nZlgQXiJQ96p3I2/Fr64LL6kn/
 HwngA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add the BC monitoring primitives. cbqri_init_bc_mon_counters() pre-arms
each MCID with the TOTAL_READ_WRITE event and allocates the per-MCID
software accumulator (struct cbqri_bc_mon_state) so subsequent reads can
extend the 62-bit hardware counter to the 64-bit byte total resctrl
expects. cbqri_bc_mon_overflow() recovers a single-wrap delta. The OVF
bit signals multi-wrap and is the caller's concern.

cbqri_find_only_mon_bc() returns NULL when zero or more than one
mon-capable BC is present. A BC's counter can only accurately back L3
mbm_total_bytes when every memory request flows through that BC.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_devices.c  | 75 ++++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h | 50 ++++++++++++++++++++++++---
 2 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
index 2a80197764a9..d4108ca1c08a 100644
--- a/drivers/resctrl/cbqri_devices.c
+++ b/drivers/resctrl/cbqri_devices.c
@@ -863,6 +863,80 @@ int cbqri_init_mon_counters(struct cbqri_controller *ctrl)
 	return 0;
 }
 
+/*
+ * 62-bit BC counter delta. Inputs must be pre-masked to
+ * CBQRI_BC_MON_CTR_VAL_CTR_MASK. The shift promotes the modular
+ * subtraction into 64-bit so a single wrap (cur < prev) yields the
+ * correct delta. Multi-wrap is handled by the caller via the
+ * hardware OVF bit (CBQRI 4.3). This function only needs to recover
+ * from at most one wrap.
+ */
+u64 cbqri_bc_mon_overflow(u64 prev_ctr, u64 cur_ctr)
+{
+	const unsigned int shift = 64 - 62;
+	u64 chunks = (cur_ctr << shift) - (prev_ctr << shift);
+
+	return chunks >> shift;
+}
+
+/*
+ * Allocate the per-MCID software accumulator and pre-arm every MCID
+ * with TOTAL_READ_WRITE so subsequent reads just snapshot the live
+ * counter.
+ *
+ * Caller responsibility: serialize concurrent invocations on the same
+ * single mon-capable BC (cbqri_resctrl uses cbqri_domain_list_lock for
+ * this).
+ */
+int cbqri_init_bc_mon_counters(struct cbqri_controller *bc)
+{
+	int i, err;
+
+	if (bc->mbm_total_states)
+		return 0;
+
+	bc->mbm_total_states = kcalloc(bc->mcid_count,
+				       sizeof(*bc->mbm_total_states),
+				       GFP_KERNEL);
+	if (!bc->mbm_total_states)
+		return -ENOMEM;
+
+	for (i = 0; i < bc->mcid_count; i++) {
+		mutex_lock(&bc->lock);
+		err = cbqri_mon_op(bc, CBQRI_BC_MON_CTL_OFF,
+				   CBQRI_BC_MON_CTL_OP_CONFIG_EVENT,
+				   i, CBQRI_BC_EVT_ID_TOTAL_READ_WRITE, NULL);
+		mutex_unlock(&bc->lock);
+		if (err) {
+			kfree(bc->mbm_total_states);
+			bc->mbm_total_states = NULL;
+			return err;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Return the single mon-capable BC, NULL if zero or more than one. BC
+ * counters can only accurately surface as L3 mbm_total_bytes if every memory
+ * request flows through the same BC.
+ */
+struct cbqri_controller *cbqri_find_only_mon_bc(void)
+{
+	struct cbqri_controller *ctrl, *only_bc = NULL;
+
+	list_for_each_entry(ctrl, &cbqri_controllers, list) {
+		if (ctrl->type != CBQRI_CONTROLLER_TYPE_BANDWIDTH)
+			continue;
+		if (!ctrl->mon_capable)
+			continue;
+		if (only_bc)
+			return NULL;
+		only_bc = ctrl;
+	}
+	return only_bc;
+}
+
 void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 {
 	/*
@@ -874,6 +948,7 @@ void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 		iounmap(ctrl->base);
 		release_mem_region(ctrl->addr, ctrl->size);
 	}
+	kfree(ctrl->mbm_total_states);
 	kfree(ctrl->mweight_cache);
 	kfree(ctrl->rbwb_cache);
 	kfree(ctrl);
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
index 48f8a6e1923e..555512cf7eab 100644
--- a/drivers/resctrl/cbqri_internal.h
+++ b/drivers/resctrl/cbqri_internal.h
@@ -63,12 +63,26 @@
 #define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
 #define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
 
+#define CBQRI_BC_MON_CTL_OP_CONFIG_EVENT 1
 #define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
 
-/* mon_ctl field masks (CC and BC share an identical OP/MCID/EVT_ID/STATUS layout) */
-#define CBQRI_MON_CTL_OP_MASK        GENMASK(4, 0)
-#define CBQRI_MON_CTL_MCID_MASK      GENMASK(19, 8)
-#define CBQRI_MON_CTL_EVT_ID_MASK    GENMASK(27, 20)
+/* Bandwidth usage monitoring event IDs (CBQRI spec Table 10) */
+#define CBQRI_BC_EVT_ID_TOTAL_READ_WRITE  1
+
+/* bc_mon_ctr_val layout (CBQRI spec section 4.3, Figure 7) */
+#define CBQRI_BC_MON_CTR_VAL_CTR_MASK    GENMASK_ULL(61, 0)
+#define CBQRI_BC_MON_CTR_VAL_INVALID     BIT_ULL(62)
+#define CBQRI_BC_MON_CTR_VAL_OVF         BIT_ULL(63)
+
+/*
+ * mon_ctl field masks (CC and BC share an identical OP/MCID/EVT_ID/STATUS
+ * layout). Keep all masks u64-wide so FIELD_MODIFY() on a u64 register
+ * never zero-extends a 32-bit ~mask and clobbers the WPRI/STATUS/BUSY
+ * fields in bits 63:32 for future support of RV32
+ */
+#define CBQRI_MON_CTL_OP_MASK        GENMASK_ULL(4, 0)
+#define CBQRI_MON_CTL_MCID_MASK      GENMASK_ULL(19, 8)
+#define CBQRI_MON_CTL_EVT_ID_MASK    GENMASK_ULL(27, 20)
 #define CBQRI_MON_CTL_STATUS_MASK    GENMASK_ULL(38, 32)
 #define CBQRI_MON_CTL_STATUS_SUCCESS 1
 
@@ -90,6 +104,19 @@ struct riscv_cbqri_bandwidth_caps {
 	bool supports_alloc_at_code;
 };
 
+/**
+ * struct cbqri_bc_mon_state - per-MCID software accumulator for BC bandwidth
+ * @prev_ctr: previous 62-bit hardware snapshot (already masked to CTR field)
+ * @chunks:   accumulated 64-bit byte total across hardware wraparounds
+ *
+ * Updated in resctrl_arch_rmid_read() under cbqri_controller::lock and
+ * zeroed by resctrl_arch_reset_rmid().
+ */
+struct cbqri_bc_mon_state {
+	u64 prev_ctr;
+	u64 chunks;
+};
+
 /**
  * enum cbqri_at - capacity controller access type for CDP
  * @CBQRI_AT_DATA: data access (CBQRI Table 1, AT=0)
@@ -159,6 +186,15 @@ struct cbqri_controller {
 	u16 *rbwb_cache;
 	u8  *mweight_cache;
 
+	/*
+	 * Per-MCID 64-bit software accumulator for the BC's mbm_total_bytes
+	 * event. Allocated by cbqri_init_bc_mon_counters() when this BC is
+	 * paired with an L3 monitoring domain, sized by ->mcid_count. NULL
+	 * on capacity controllers and on BCs that are not mon-paired.
+	 * Protected by ->lock along with the surrounding MMIO sequence.
+	 */
+	struct cbqri_bc_mon_state *mbm_total_states;
+
 	struct list_head list;
 
 	struct cache_controller {
@@ -201,4 +237,10 @@ int cbqri_read_rbwb(struct cbqri_controller *ctrl, u32 closid, u64 *rbwb_out);
 
 int cbqri_read_mweight(struct cbqri_controller *ctrl, u32 closid, u64 *mweight_out);
 
+u64 cbqri_bc_mon_overflow(u64 prev_ctr, u64 cur_ctr);
+
+int cbqri_init_bc_mon_counters(struct cbqri_controller *bc);
+
+struct cbqri_controller *cbqri_find_only_mon_bc(void);
+
 #endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */

-- 
2.43.0

