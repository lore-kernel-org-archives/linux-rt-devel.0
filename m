Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310033F6C5A;
	Mon,  1 Jun 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346187; cv=none; b=Ir3qjxlGt5NQS8tCTEeHk8R3TWuQxMOIl8VPfl9sPzsiYJKdlIOO6vYXqnaMpssP0cuHwwrAqXt5pjNL48qCj26Tg/LRG9ykz3j0o21KjfA6KFJmJuXsq5DiYWFpuFa8v0vupY2Rm9EH7i8EMoKM6blsSjepOFDoaPdq4QqSYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346187; c=relaxed/simple;
	bh=AWRHihJSBi+LIrOoIsOzoxnsBG0+4NVU5YSaIMOxEs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZaFi0klSDxeCCpZeU6vEtJL5FWFk9ADQroQ9yNwv2XV06HjBZ3529mxaV8WsDG1+4b+LxBRuiFXYwGwdkS4NSyCUKjASGzxnVJG7fPqTYUDU0xy1Gx3qGq09CfjuH1hvJ5jFUqsbTtK+P/rPma21qgW3I+cAy0zyd3sH3Grfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4EDcD/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4EDcD/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C81F008A2;
	Mon,  1 Jun 2026 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346186;
	bh=04z5b3ENFFStDILh5daSgPFr7SyjhKEetoj74bl6s2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N4EDcD/494hQTJe4Z54xn8R31VLX1tGYAWu/wOvCv15H+JZ5j/quW+JmTtNI/6zPT
	 UIG1axiDwdSzkpAizwBy+WWc+N9OhUdlEKFYmcH+hRh9DaqV7e0cn+j+upHN9dR770
	 VwkMT4qcD3K2H54TgD2cUCKCl8MajpxOdTilhoxUc0BNMxY0j8QXYLB/l0d5oC/W/f
	 7skH61tjyhUdzxhXDe2acfesYtrQsEypUb8v+0MOFwXE7wBLWNKx5PGNJ1bZOn3TXp
	 LpoCOLqr0/l9vfg7qAJWaD/ZHRw7NY9nCd+XOWQmRAkJytXPVmS4YBJWOPiyiQLpO7
	 vsXa6CsrAHg8g==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:35:58 -0700
Subject: [PATCH RFC v6 04/18] fs/resctrl: Add resctrl_is_membw() helper
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-4-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3572; i=fustini@kernel.org;
 h=from:subject:message-id; bh=AWRHihJSBi+LIrOoIsOzoxnsBG0+4NVU5YSaIMOxEs8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnX68MtA7IdD/cyz767HerOHxIhE6sfutTnEfs3oR
 mJ01wHrjlIWBjEuBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBEgrYwMvzUmfE49KbQ7Iyv
 0b+u21xhnyWd9+TlY6mvFv5hHfNnzqxmZDjwJKXw+hqerg8nAy8cKz+07eu6bTGbZyh7i1x3PMk
 3qYkBAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Four sites in fs/resctrl distinguish bandwidth resources (MBA, SMBA)
from cache resources by explicit rid match:

  fs/resctrl/ctrlmondata.c parse_line()
  fs/resctrl/rdtgroup.c    rdtgroup_mode_test_exclusive()
  fs/resctrl/rdtgroup.c    rdtgroup_size_show()
  fs/resctrl/rdtgroup.c    rdtgroup_init_alloc()

Replace the open-coded MBA/SMBA tests with a single resctrl_is_membw()
helper keyed on schema_fmt (RESCTRL_SCHEMA_RANGE). No functional change:
every existing RESCTRL_SCHEMA_RANGE resource is MBA or SMBA today.

This isolates fs/resctrl from the addition of further bandwidth resource
types so the four call sites do not have to be updated for each new rid.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 fs/resctrl/ctrlmondata.c |  3 +--
 fs/resctrl/internal.h    |  2 ++
 fs/resctrl/rdtgroup.c    | 14 +++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 9a7dfc48cb2e..d9f052700941 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -245,8 +245,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	if (WARN_ON_ONCE(!parse_ctrlval))
 		return -EINVAL;
 
-	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
-	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP && resctrl_is_membw(r)) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
 		return -EINVAL;
 	}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 1a9b29119f88..76187987b2ee 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -397,6 +397,8 @@ void mbm_handle_overflow(struct work_struct *work);
 
 bool is_mba_sc(struct rdt_resource *r);
 
+bool resctrl_is_membw(struct rdt_resource *r);
+
 void cqm_setup_limbo_handler(struct rdt_l3_mon_domain *dom, unsigned long delay_ms,
 			     int exclude_cpu);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dfdaa6f9d8f..0f331bf5ce82 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1412,7 +1412,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
+		if (resctrl_is_membw(r))
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
@@ -1555,6 +1555,12 @@ bool is_mba_sc(struct rdt_resource *r)
 	return r->membw.mba_sc;
 }
 
+/* RANGE schema is bandwidth (MBA/SMBA). BITMAP is cache. */
+bool resctrl_is_membw(struct rdt_resource *r)
+{
+	return r->schema_fmt == RESCTRL_SCHEMA_RANGE;
+}
+
 /*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *
@@ -1616,8 +1622,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 					ctrl = resctrl_arch_get_config(r, d,
 								       closid,
 								       type);
-				if (r->rid == RDT_RESOURCE_MBA ||
-				    r->rid == RDT_RESOURCE_SMBA)
+				if (resctrl_is_membw(r))
 					size = ctrl;
 				else
 					size = rdtgroup_cbm_to_size(r, d, ctrl);
@@ -3648,8 +3653,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		if (r->rid == RDT_RESOURCE_MBA ||
-		    r->rid == RDT_RESOURCE_SMBA) {
+		if (resctrl_is_membw(r)) {
 			rdtgroup_init_mba(r, rdtgrp->closid);
 			if (is_mba_sc(r))
 				continue;

-- 
2.43.0

