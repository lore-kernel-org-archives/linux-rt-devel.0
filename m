Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922D3F789D;
	Mon,  1 Jun 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346188; cv=none; b=r4/aYGknZnfc1daOI0DDsMxu6PH4/EQC59wpZqwWvMMQrg57UgF9NQ6KrOJrkIUFadX/L3AAHpfELJ7Mv3S2EZ2ch2V2aW3NSckX4A6m3jLIaXe+D7ZBjQGzaTWX67vXXkGwNje8ArQw3ByyEeiDDB0gVF+rBSJH7VwMTMOcPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346188; c=relaxed/simple;
	bh=5R/JdWFi++9znbUpG3cGFvBtrlKO+JDslGJA+1+iOLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0aq+w2/emwhNNjUIpglO9xAS9vYOmX2F3aoIUPr52qIZW06Xhk9E7C802K386suMFYHzq/QR9i5h7oGHt7WOjVIdtluGvV4olvXhNBdLDXKhJ7mPTg/bISEk89Vcjqxum0tWWE9ipv47wuXGikEkLaERcSdQs6qq1xSdtESacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3SVo7zy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3SVo7zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE1E1F008A3;
	Mon,  1 Jun 2026 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346186;
	bh=f9ZOFiPohiYSKhbWWzIEk2xjvwSzBQ/tKoIQXjkNAxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m3SVo7zyq96FMlVQkDyefmhThVvqpBHzYEwM01u/+hQQorVfnMQIJU0Tis2CFRaeC
	 QIVEkTgLTtss2oupuozZKDtPnAMcNq8zePDPeGvD8ksvBalYIIXHA10w+u8gTam8G4
	 JAQ3cvFJKmwg0L3vUCUxJwazAZYYaXUroPdGSeN9P84OQFcaQIDtpJ6RQHUMr4Q2xK
	 uuTEpUWKO7XP3JG/qrJRQlrfQ66drKDKVxQdKFPJseEqBOc5n+RUT97HqctFfL+Bx2
	 9HBetHTXHlWWgMHgMA72OT0io/s2GByTMz52JjsBQvnzkFuV2sgjrBDmZr7lSa8+El
	 3pEdX3lSUKNDg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:35:59 -0700
Subject: [PATCH RFC v6 05/18] fs/resctrl: Add RDT_RESOURCE_MB_MIN and
 RDT_RESOURCE_MB_WGHT
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-5-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=fustini@kernel.org;
 h=from:subject:message-id; bh=5R/JdWFi++9znbUpG3cGFvBtrlKO+JDslGJA+1+iOLc=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnWam3v/ImetyEH5AsFixXvqZ3++YV6yT2LF/ymfJ
 p1/2bJ0XUcpC4MYF4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgIr+vMPxmPb4qM2Z59kSF
 hqP2RsHVp6/P+Ma6wme/VmPcv6pyvg/vGBm2PPA/O+31e86133K6dTclNsue+bbfw+n95idC65k
 0ZMRYAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Introduce bandwidth controls which are semantically different from
the throttle-based MB resource:

 - RDT_RESOURCE_MB_MIN: minimum reserved bandwidth
 - RDT_RESOURCE_MB_WGHT: weighted share of unreserved bandwidth

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 fs/resctrl/rdtgroup.c   | 4 +++-
 include/linux/resctrl.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0f331bf5ce82..02733b11e115 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1555,7 +1555,7 @@ bool is_mba_sc(struct rdt_resource *r)
 	return r->membw.mba_sc;
 }
 
-/* RANGE schema is bandwidth (MBA/SMBA). BITMAP is cache. */
+/* RANGE schema is bandwidth (MBA/SMBA/MB_MIN/MB_WGHT). BITMAP is cache. */
 bool resctrl_is_membw(struct rdt_resource *r)
 {
 	return r->schema_fmt == RESCTRL_SCHEMA_RANGE;
@@ -2402,6 +2402,8 @@ static unsigned long fflags_from_resource(struct rdt_resource *r)
 		return RFTYPE_RES_CACHE;
 	case RDT_RESOURCE_MBA:
 	case RDT_RESOURCE_SMBA:
+	case RDT_RESOURCE_MB_MIN:
+	case RDT_RESOURCE_MB_WGHT:
 		return RFTYPE_RES_MB;
 	case RDT_RESOURCE_PERF_PKG:
 		return RFTYPE_RES_PERF_PKG;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 006e57fd7ca5..9529ed0d1fdf 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,6 +53,8 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_MB_MIN,
+	RDT_RESOURCE_MB_WGHT,
 	RDT_RESOURCE_PERF_PKG,
 
 	/* Must be the last */

-- 
2.43.0

