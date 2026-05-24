Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792C3B83FB;
	Sun, 24 May 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667055; cv=none; b=JkkIPYAzyM+WDbViBUSe9vmsoFSM1pzD34z/jYktXY6BpNepfXK71zRZ8rj9QylDVHGpq5hhfM/sYTivXyV5H4d5bi1tswmhKreWoC3Pc6Avk6/QzASbpQzeOcN48xyypTiAM/Zu+6qB40843LZaAPz35KrRnBu3nufwxS647IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667055; c=relaxed/simple;
	bh=AWRHihJSBi+LIrOoIsOzoxnsBG0+4NVU5YSaIMOxEs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/kzarV9QqH/55tWJmotYDRFIgLgyMFVCBwHCoiN8MHpctsYnkJiYPfA5ocgzAzBCvtwDTb79F72z5cBfCvOQsk+4e4ihRJNjzDLUFyATkmNpiWnVH3DDh5Y4Gi8EORrUP5v1OAdd9QHTuHh2/cqX+sKQuHwxLxwZ3e/iVyshxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aocyLNmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aocyLNmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F831F0155C;
	Sun, 24 May 2026 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667054;
	bh=04z5b3ENFFStDILh5daSgPFr7SyjhKEetoj74bl6s2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aocyLNmKzmXQ9FlssytmARSxj1PZsMH67qwm22RzG6SBtcNMrhjiNYkLkwmIlkaLL
	 BSrU23bZJI7DUIDYdVSBlm5VDdqdZ0aZ40vzm/dcoH4kS19uaPu0lFX0JCR1017WxJ
	 JrjzayD0/A8ZXR1yG350GzIgar/jNM3q3nJZ9JnQzgkyqVFf0f6FQhvsSXXYJBJuno
	 t2rhAYzt+6+PCgh5tKYDaZ3XB/KTliu4zn1B0pproBmTumtJcZTQXVR2UezO4G/h3r
	 Pc9HPFpETnkgvVsoKvI6Hxzfks5xlQYDCZk/AYhhyqpeP+Ar7MnXhDi8RD7Tg2ta0x
	 DyoZGgU3BKsqQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:34 -0700
Subject: [PATCH RFC v5 04/18] fs/resctrl: Add resctrl_is_membw() helper
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-4-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3572; i=fustini@kernel.org;
 h=from:subject:message-id; bh=AWRHihJSBi+LIrOoIsOzoxnsBG0+4NVU5YSaIMOxEs8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8iIurXa8YCswwyR44Jmc01np96aZh52ba6GioO3/
 +M7h7JkOkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATSVnAyPDkl/bc7Y5b+rtt
 ZRe0rFp98dPBthq9qIi6vIiHfaUcnCaMDKvqV/b+WOVWKvn1gLrzyd19D/Y7R3CFzBcuvtAf4r2
 VhxEA
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

