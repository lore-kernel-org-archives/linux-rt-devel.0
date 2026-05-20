Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469213E5577;
	Wed, 20 May 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284419; cv=none; b=mO2RiL8OUbgQaXZKxyCL4YRqZTAv6FlTQhW0AuGDj9vcaChuV5RaTiUVL32oG1zLJtLauV5HESMS6xhXFYOExPYBd0sEWsQJvraATnMC6hnCCFO3M0t9c/FoPhNBgNYCD0MrbZyd9eIBVGtWJqLP0dtvRZhcebaXq6N9/w8t228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284419; c=relaxed/simple;
	bh=CSyfguuVNxcphI8M8hXCKwfgO28jhSOmDsVMJc+ujrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2xAOejPhdlkvcbUC6A1FvJNrl/HXini5tlPbo5zM/B66Yf58Sp3EopCC3a11wrQKPcKD6i8U3L0JTrbC0u/ExF1lJuLJiwECwk6XsDH2aVAB6QrPcvdNYEgTbH23ckh4fCXKQ30zytBsTbwEDuJfnyY+ZTWSEJHxIJ9ITOM/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5Mn4E8W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5Mn4E8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284415; x=1810820415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CSyfguuVNxcphI8M8hXCKwfgO28jhSOmDsVMJc+ujrQ=;
  b=e5Mn4E8WwpdIH/gKukTJR3N8FkL89uK32yY471WZX/hiVlNxrgV560UY
   V0SzqRnvB1LVmKbrbkqWDEXdJcDtv/CbNU/ioQQavAN9X5zTsDc4y1bpZ
   t+WBDoz/y19dAA0ZsaCLB6KlC5q12Si6wxRme7/h7vdyhuk/J4yB+4Xlv
   z+CCg2iKqWRpJ8gac0Z0pGY0nyPE0et/1twvjKmN0OO0EdEjLakioiQGj
   ZqtZFHb6NAGx6DU0cSjOahbo0J4muYeloRtuen7bG9sIsEHOUzVo1BIbQ
   XiUCRtC22ixCcPH/ODGKIxTsAxY0FjFhNQB+yaboiT1E4Zj/hvFrzxsX8
   A==;
X-CSE-ConnectionGUID: zHsIGs4MS3OjvdczvVQc9w==
X-CSE-MsgGUID: NyHmcFlfQFG+eFFFjJoZxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146460"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:11 -0700
X-CSE-ConnectionGUID: k+TxXo9eR0qm21GvNNIDtg==
X-CSE-MsgGUID: k3bEo73ySUaqu9hA4lv5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923796"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:10 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v10 08/25] x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
Date: Wed, 20 May 2026 06:38:11 -0700
Message-ID: <20260520133909.409394-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX architecture uses the "SEAMCALL" instruction to communicate with
SEAM mode software. Right now, the only SEAM mode software that the kernel
communicates with is the TDX module. But, there is actually another
component that runs in SEAM mode but it is separate from the TDX module:
the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
that communicates with it is the BIOS which loads the TDX module itself at
boot. But, to support updating the TDX module, the kernel now needs to be
able to talk to it.

P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
concurrency requirements.

Add a P-SEAMLDR wrapper to handle these differences and prepare for
implementing concrete functions.

Use seamcall_prerr() (not '_ret') because current P-SEAMLDR calls do not
use any output registers other than RAX.

Note: Despite the similar name, the NP-SEAMLDR ("Non-Persistent")
differs sharply from the P-SEAMLDR. It is an authenticated code module
(ACM) invoked exclusively by the BIOS at boot rather than a component
running in SEAM mode. The kernel cannot call it at runtime. It exposes
no SEAMCALL interface.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
---
v10:
 - make "main act" solution statement in a prominent place [Dave]
---
 arch/x86/virt/vmx/tdx/Makefile  |  2 +-
 arch/x86/virt/vmx/tdx/seamldr.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c

diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
index 90da47eb85ee..d1dbc5cc5697 100644
--- a/arch/x86/virt/vmx/tdx/Makefile
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += seamcall.o tdx.o
+obj-y += seamcall.o seamldr.o tdx.o
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
new file mode 100644
index 000000000000..65616dd2f4d2
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * P-SEAMLDR support for TDX module management features like runtime updates
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+#define pr_fmt(fmt)	"seamldr: " fmt
+
+#include <linux/spinlock.h>
+
+#include "seamcall_internal.h"
+
+/*
+ * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
+ * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
+ * be made with interrupts disabled, where plain spinlocks are prohibited in
+ * PREEMPT_RT kernels as they become sleeping locks.
+ */
+static DEFINE_RAW_SPINLOCK(seamldr_lock);
+
+static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
+{
+	guard(raw_spinlock)(&seamldr_lock);
+	return seamcall_prerr(fn, args);
+}
-- 
2.52.0

