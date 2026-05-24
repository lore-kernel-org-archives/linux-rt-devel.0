Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8793B8405;
	Sun, 24 May 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667063; cv=none; b=fK7+w+h2NWUeXU7Wu8PKwEBfm/rrqYCl/rL4UPnISqoEkW2SHfbpG9v8ffyfe/mNAvrclGtGOgYtA4JBpVE5FZM4vhMCPQtE4fL1Pxu8OiDzqzmrdyQ0ocDnLeX8jxOepFKRpIJg7yJEay9xEkNKhVtCBdNs28XXVW714v1wsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667063; c=relaxed/simple;
	bh=umPX9KI/Gk5be4QxBnpv0rW9Oy0Ozoiycv8rX5MjK6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwhFJGspq0U9qLjlBctdJa1pe++SmQnr88n3v3quntzJ55lgNS/B6MWYc0RGEN7eGkxBTbF2c/R9oLdqRR6VD4oAtDvt/fa/wh3Gvoy7J6fXhcnacl2EbADp35N/78VhvUJQFaOXhtt+xTgVSUAd05mpk4U1My14otrzkDurzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+92C/1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+92C/1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04961F0155F;
	Sun, 24 May 2026 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667055;
	bh=bMpLloap6PiHKBmR2q+lkFW8XbOS+M/R8KIqzK/QRe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F+92C/1auw/zl+CcnOKmKGFuP9GPhmcl/vLhe3laue9CQuGhWoOfFF/nQimXkfQ61
	 /fDfEVV3H3ey17QGZiCfdtf1UCnzWqnl8qJVc+HbyyfgIbeCzlAv1zD4smopZbk6E0
	 4ou6vDn6KhWhJbC1Ln90oi0qYVymKH/tJzZR7ofm4oNhCeHo4LDu0v/TJkqBSnIClQ
	 krXo7XF3lixAK2LDHStLRfjUWNDsKTpmGrh6bcYF+olJDxUDFETtnxNpwFccixp+lP
	 OLzEIaDoNnbEvU4dimugTP9kOjRsZLCvkqKBGChLCv74P+xn4GPRL1FYqdpExRjNFZ
	 /bt6ghIJHTxzA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:36 -0700
Subject: [PATCH RFC v5 06/18] fs/resctrl: Let bandwidth resources default
 to min_bw at reset
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-6-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=fustini@kernel.org;
 h=from:subject:message-id; bh=umPX9KI/Gk5be4QxBnpv0rW9Oy0Ozoiycv8rX5MjK6Y=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8icN8FsBbue+1+zLY+4pQ/vWcvN57mm+1lDU+Xmf
 2dkszXFOkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATiVnB8IfbQziwwqh32U2D
 l7tm2byf8pNh6g7OGQ8k932/zLziMLcUI8PkK4/yaiMbp9bt3bd/qdOT1mDrJkEmvj7WVsvM4gU
 M3rwA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Bandwidth resources reset to max_bw on group creation today, which is
the right default for MBA and SMBA. However, it is the wrong default for
hardware whose registers form a sum-constrained reservation: defaulting
every new group to max_bw would immediately violate the sum on the first
mkdir.

When default_to_min is set, resctrl_get_default_ctrl() returns min_bw
for the resource. The existing MBA and SMBA behavior is not changed.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 include/linux/resctrl.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9529ed0d1fdf..bcbc166412ef 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -247,7 +247,13 @@ enum membw_throttle_mode {
 /**
  * struct resctrl_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
- * @max_bw:		Maximum memory bandwidth value, used as the reset value
+ * @max_bw:		Maximum memory bandwidth value a group can be
+ *			configured with
+ * @default_to_min:	When true, the default control value for new
+ *			groups and reset is @min_bw instead of @max_bw.
+ *			Drivers whose hardware enforces a sum constraint
+ *			across groups (e.g. CBQRI MB_MIN) set this so
+ *			mkdir does not overflow the sum.
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @arch_needs_linear:	True if we can't configure non-linear resources
@@ -259,6 +265,7 @@ enum membw_throttle_mode {
 struct resctrl_membw {
 	u32				min_bw;
 	u32				max_bw;
+	bool				default_to_min;
 	u32				bw_gran;
 	u32				delay_linear;
 	bool				arch_needs_linear;
@@ -405,7 +412,7 @@ static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
 	case RESCTRL_SCHEMA_BITMAP:
 		return BIT_MASK(r->cache.cbm_len) - 1;
 	case RESCTRL_SCHEMA_RANGE:
-		return r->membw.max_bw;
+		return r->membw.default_to_min ? r->membw.min_bw : r->membw.max_bw;
 	}
 
 	return WARN_ON_ONCE(1);

-- 
2.43.0

