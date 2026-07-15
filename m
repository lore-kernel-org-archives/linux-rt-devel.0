Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BA1F4C96;
	Wed, 15 Jul 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075029; cv=none; b=c8o+oj+H5sYsDzBqTGcBccJ3Zr/37Vb2ZVCL4ej6ap8d+Ehzvbj8dwVtkxDztmrVP5OidpHerQAPSe6cP3ULFr4fwaQ50mQkb5vle/sTMUol83Pqu2NRsC4A37k1j1IIWffNWTQKvIbJT42u5G7ADlcvLwW8WWe/7HE6l7Y72cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075029; c=relaxed/simple;
	bh=ebgjBWWGoiz8bFe8aM1k+b6Koj+oeRqpY3Kqeizgd4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruIBk/z3pPG1aQnBiAvFel+AKl9BQ9ySN8WdKB6YRm4OEmnCaKY1lgwZu/GPNxiwg1DHPmUvS6To923LT9V2GN+Ob/TJGmt1GxmFd0rRXnv7iMyuvfbsKHiX3d8RU+rz92lNRmuNRnv3VGWhZpuymqJtWRAzQ0OB2mRoUkSUTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVE6HD3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVE6HD3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE11F00ACA;
	Wed, 15 Jul 2026 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784075026;
	bh=YDA0Kty7PQNT08Qk9i1E78Ah1lcxCYarON76a0LRZ+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iVE6HD3RFWcV/W8PADwEm6ZJVJoOB2cQii4UyA0zs+rpBSx7Wqb+fHFV/NVSKd+Qa
	 iFupWMYkZwrE/XRBjVypZz7QBnX7haRf+Bgb88540rU2wU1fgxkUs0Ge9u4G2Dh6Oz
	 7kZiHPlTtPafUHr51URy+WjpmLLh7JaQJnC/HqthkSDeofihvOnteB/vk7y+yjtHmz
	 IcCqrQNnNvF2BG+sFDb6haZy0DADu4hvy5yezCdZfAm8Ms6qg063gbCjYsXNaGeWtw
	 Qwrmj+zqZLSJ/gYl4jgY3YwzOmF2aoceoPHyxT12beK0tveZq/I0lxBRFseUGiK1mH
	 273QDOHTQj5YQ==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Jul 2026 17:23:23 -0700
Subject: [PATCH v5 1/8] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-dfustini-atl-sc-cbqri-dt-v5-1-b0ae7e9c932e@kernel.org>
References: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
In-Reply-To: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
 guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
 Peter Newman <peternewman@google.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=fustini@kernel.org;
 h=from:subject:message-id; bh=ebgjBWWGoiz8bFe8aM1k+b6Koj+oeRqpY3Kqeizgd4c=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSFXRYo8a/yDzd+sO3LC/Yqo977K8tizzE+9rApYgnaJ
 nJ9wuELHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJHLNg+KdvdO3V7hkbnQ/s
 LzBTk+XpsihetcPLMSztbPhOhnPS+v8ZfjGlSWaFCf/WSGRf1L197fec7giZsw8vVs0Iejd/3qV
 fm/gB
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
extension v1.0.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 5ffc40d599c0..c9dc5d80c0ea 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -232,6 +232,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssqosid
+          description: |
+            The standard Ssqosid extension for Quality of Service ID is
+            ratified as v1.0 in commit d9c616497fde ("Merge pull
+            request #7 from ved-rivos/Ratified") of riscv-ssqosid.
+
         - const: ssstateen
           description: |
             The standard Ssstateen extension for supervisor-mode view of the

-- 
2.43.0

