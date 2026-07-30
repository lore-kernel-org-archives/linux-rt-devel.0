Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E61DFDE;
	Thu, 30 Jul 2026 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373907; cv=none; b=Hk/p+O/nWA3B0zFmbOj9w8bfiB+jTMKA+oHQwRRlT18R3km1nsJFmHXbJ8qCmGhwHKNpxPbF4xVPgdmNx5pqVG1uU8D3NealimOL37P6UKbIqZ8jI+Qwyr6TW5ii6iD2ap2GQInWBsJe/eQVb/nyVGpniletJSBiLkd3qslWROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373907; c=relaxed/simple;
	bh=ebgjBWWGoiz8bFe8aM1k+b6Koj+oeRqpY3Kqeizgd4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XW3IfXp0bB9SiRmLBXPsf+nl1gka0F5q+lsXLfLOwneDUdkjhHWZtHTFKQcz4/cqkLiAmxsxlkpL1j65+yggeEhktUm8dymJ3pNaGJBVAzpAIFFVwVkEEJysB17rYgYUjQCqSG84vDmHexMCt4b5A+WgwahKQ6YRuv3yFX0rs7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKOUynMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKOUynMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE81F00ADB;
	Thu, 30 Jul 2026 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373906;
	bh=YDA0Kty7PQNT08Qk9i1E78Ah1lcxCYarON76a0LRZ+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KKOUynMWINMtL/sn/xLshc2icqB+XhSrqDuVpsBiKtNp+BDKzntI3UuANmacpSEGE
	 fgDhbdHSHH0JRr8muWw9AtiUHBNY9kTBs6mVYIGQ0Z+VHvXaXpqI2q38hyiopEwDSG
	 TqRgmPMXbDSpxc8gxHnahj1eK22giAckvdeCzWGme2UIyTq+7ZI/kXJkpUstrjZKmE
	 jbLvMsLUFpizbKdkZkpN1fhyIgC8yBQ0fzTfUZo+Ed5/S9ws15LW6cbpmunNbBkOew
	 51NzFLSuIgR6QQeO9d4RlUDIO8FP+xcbXaI6GzhTTdx57PrVUxYXMCSpU+G43hceS9
	 oeM+a8o3RfTsw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 29 Jul 2026 18:11:28 -0700
Subject: [PATCH v6 1/8] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-dfustini-atl-sc-cbqri-dt-v6-1-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
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
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRlLblwLmmKxGpHl4LGK408EdtuhzCFBN7Y/PxMy5uFG
 vmrC1zFO0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATmXKC4X9K2NS8y8Jf/5j6
 8J7fM+lonMSsv209E6+qOK6N2aZw7K4tI0NH0L2f3iXvPwTuP8n595tNvMGHa4zvvaKusAUtcTw
 pHcEDAA==
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

