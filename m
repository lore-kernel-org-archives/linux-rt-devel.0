Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9137E315;
	Mon, 11 May 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476274; cv=none; b=gZq0UlqG8CbRrJvyQCMRByRVMDAttDQryG/7MWYvfeyZsneM27RJbotjMoTgILwBmtIKiEjSQiGlKuEO6jz0upGAx46zw6e+0j6y7VWe0kNIIP1a3DfNw1St8BrTemfUpBLCULhOjv7FJ8rF8H6jYyBeIiBjB5ofHsUyhZee+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476274; c=relaxed/simple;
	bh=+Ka0NMSXOMcysYspQYgekhunhqZmoAxRwXrsbr/Fqnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsyvodggZqECsr5buWtHTBeJwKuq6UXNERc1UMt0MbTreqcPQmv1qf+E0H8yjgv7AtHyBfkCZup6uJGpwI2xzL4cGU2ORtb+P46aqHRRrdZd2JS114uQgfB4qRfSW7+caNsI9qskEFl+3thi9ZrmyYnwD2zyD278+6K5II0rDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDs0NUP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDs0NUP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C84C4AF11;
	Mon, 11 May 2026 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476274;
	bh=+Ka0NMSXOMcysYspQYgekhunhqZmoAxRwXrsbr/Fqnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RDs0NUP6N30e0OM3qjXSTBx3n3Gul3xBLvoR4ynWl//zrCMIjs2ZHEvrLc/KIAnNq
	 mKHohEK9/dTLbftY1mtsMYkGdEd/Ps2KrNJkpD2CYszAmrjQEXrd/YRXe2zHXAtX0X
	 rkdcH9rZWlHjc8eidfrZ3CbUCXEr8bpqQBqXq/MgppGOWmBEWJ1Qg6Ee/5emKl9plT
	 p73ODgVRwO8xoIZFN2A8XJewWOREuwTbNwvxodAIAV4GZMVzf0mS8ki3a69U8hZ0FS
	 nVR7nlBp3tM7yyhsrfDyGou7bh5zDp7BosfkfZllA6Y3KF96BpoCYOWhH/NavSkmYB
	 Uae60Er++Tr4w==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:04 -0700
Subject: [PATCH RFC v4 08/18] riscv_cbqri: Add capacity controller
 monitoring device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-8-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6207; i=fustini@kernel.org;
 h=from:subject:message-id; bh=+Ka0NMSXOMcysYspQYgekhunhqZmoAxRwXrsbr/Fqnk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprw+s/9F834TPW8R62ce4l05bGHmVgZ3ugTXbspN3
 Fz2eMvTjlIWBjEuBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBEmJsYGfY/FFl39sbGmk1Z
 yhITNs/7/l4sIubJ+6R52m/vh7/RvDid4b/TtW98U2S0njy4Ll+ldVr18Oqo1rMxjM6HRU2Tvv1
 aNI8HAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add the CC monitoring primitives. cbqri_init_mon_counters() pre-arms
every MCID with the Occupancy event so a subsequent READ_COUNTER
just snapshots the live counter without re-configuring the slot.

cbqri_probe_cc() leaves ctrl->mon_capable false when cacheinfo has
not given a non-zero cache_size, since the byte conversion would be
meaningless. cbqri_mon_op() takes a reg_offset and serves both CC
and BC mon_ctl registers, which share an identical layout.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_devices.c  | 85 ++++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h | 21 ++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
index dc76a146e34d..e46b02d2c50d 100644
--- a/drivers/resctrl/cbqri_devices.c
+++ b/drivers/resctrl/cbqri_devices.c
@@ -105,6 +105,46 @@ static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation,
 	return 0;
 }
 
+/*
+ * Issue a monitoring op on a CC or BC controller's mon_ctl register at
+ * reg_offset (CBQRI_CC_MON_CTL_OFF or CBQRI_BC_MON_CTL_OFF). The CC and
+ * BC mon_ctl registers share an identical OP/MCID/EVT_ID/STATUS layout, so
+ * one helper covers both. Caller must hold ctrl->lock.
+ */
+int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
+		 int operation, int mcid, int evt_id, u64 *out_reg)
+{
+	u64 reg;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	if (ctrl->faulted)
+		return -EIO;
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout before starting operation\n");
+		return -EIO;
+	}
+	FIELD_MODIFY(CBQRI_MON_CTL_OP_MASK, &reg, operation);
+	FIELD_MODIFY(CBQRI_MON_CTL_MCID_MASK, &reg, mcid);
+	FIELD_MODIFY(CBQRI_MON_CTL_EVT_ID_MASK, &reg, evt_id);
+	iowrite64(reg, ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout\n");
+		return -EIO;
+	}
+
+	if (FIELD_GET(CBQRI_MON_CTL_STATUS_MASK, reg) !=
+	    CBQRI_MON_CTL_STATUS_SUCCESS)
+		return -EIO;
+
+	if (out_reg)
+		*out_reg = reg;
+
+	return 0;
+}
+
 /*
  * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
  *
@@ -310,6 +350,7 @@ static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
 
 static int cbqri_probe_cc(struct cbqri_controller *ctrl)
 {
+	bool has_mon_at_code = false;
 	int err, status;
 	u64 reg;
 
@@ -361,6 +402,28 @@ static int cbqri_probe_cc(struct cbqri_controller *ctrl)
 	}
 	cpus_read_unlock();
 
+	/* Probe monitoring features */
+	err = cbqri_probe_feature(ctrl, CBQRI_CC_MON_CTL_OFF,
+				  CBQRI_CC_MON_CTL_OP_READ_COUNTER, &status,
+				  &has_mon_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_MON_CTL_STATUS_SUCCESS) {
+		/*
+		 * Occupancy is reported to userspace in bytes, computed as
+		 * cache_size * counter / ncblks by the resctrl glue. If
+		 * cacheinfo has no cache_size, leave mon_capable false so
+		 * the file is not exposed at all rather than silently
+		 * returning 0.
+		 */
+		if (!ctrl->cache.cache_size)
+			pr_debug("CC @%pa: cache_size unknown, occupancy monitoring disabled\n",
+				 &ctrl->addr);
+		else
+			ctrl->mon_capable = true;
+	}
+
 	/* Probe allocation features */
 	err = cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
 				  CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
@@ -428,6 +491,28 @@ static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 	return err;
 }
 
+/*
+ * Pre-arm every MCID with the Occupancy event so a subsequent READ_COUNTER
+ * just snapshots the live counter rather than re-configuring the slot.
+ * Called once per CC during resctrl-side cpuhp online for the L3 monitoring
+ * domain.
+ */
+int cbqri_init_mon_counters(struct cbqri_controller *ctrl)
+{
+	int i, err;
+
+	for (i = 0; i < ctrl->mcid_count; i++) {
+		mutex_lock(&ctrl->lock);
+		err = cbqri_mon_op(ctrl, CBQRI_CC_MON_CTL_OFF,
+				   CBQRI_CC_MON_CTL_OP_CONFIG_EVENT,
+				   i, CBQRI_CC_EVT_ID_OCCUPANCY, NULL);
+		mutex_unlock(&ctrl->lock);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 {
 	kfree(ctrl);
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
index 6a581a7e417b..b1169ffc599f 100644
--- a/drivers/resctrl/cbqri_internal.h
+++ b/drivers/resctrl/cbqri_internal.h
@@ -11,6 +11,8 @@
 
 /* Capacity Controller (CC) MMIO register offsets. */
 #define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_MON_CTL_OFF      8
+#define CBQRI_CC_MON_CTL_VAL_OFF 16
 #define CBQRI_CC_ALLOC_CTL_OFF   24
 #define CBQRI_CC_BLOCK_MASK_OFF  32
 
@@ -39,6 +41,20 @@
 #define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
 #define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
 
+#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
+
+/* mon_ctl field masks (CC and BC share an identical OP/MCID/EVT_ID/STATUS layout) */
+#define CBQRI_MON_CTL_OP_MASK        GENMASK(4, 0)
+#define CBQRI_MON_CTL_MCID_MASK      GENMASK(19, 8)
+#define CBQRI_MON_CTL_EVT_ID_MASK    GENMASK(27, 20)
+#define CBQRI_MON_CTL_STATUS_MASK    GENMASK_ULL(38, 32)
+#define CBQRI_MON_CTL_STATUS_SUCCESS 1
+
+/* Capacity usage monitoring event IDs (CBQRI spec Table 4) */
+#define CBQRI_CC_EVT_ID_NONE         0
+#define CBQRI_CC_EVT_ID_OCCUPANCY    1
+
 /* Capacity Controller hardware capabilities */
 struct riscv_cbqri_capacity_caps {
 	u16 ncblks;
@@ -122,4 +138,9 @@ int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
 int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
 			    enum cbqri_at at, u32 *cbm_out);
 
+int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
+		 int operation, int mcid, int evt_id, u64 *out_reg);
+
+int cbqri_init_mon_counters(struct cbqri_controller *ctrl);
+
 #endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */

-- 
2.43.0

