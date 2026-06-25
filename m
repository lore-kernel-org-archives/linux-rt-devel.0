Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377A36F915;
	Thu, 25 Jun 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351646; cv=none; b=opsXAHpa2ICXf555LedqEO7EDAyVl+LGH9GMTkgDrVoLaGz6wi1q5Yx6uhW60kliuzUOgop2+T7F2MoDc6Kc7UPGmtyJOZTKvpa79yMXboFXDLvjffOye/Jd4G7thNVRJoY9c7/SznoezTOKHAhRsL4q0UYWueZKhje7+Dbc4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351646; c=relaxed/simple;
	bh=sf83KK78LgG79pAz1A/Eb83woX0oPlv3EBhOYw74nG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWya39VFwORdVnGhMo5lo5c9EJaQA6n9/Jpo2YvkkumRasrln2OPGEUD4gheSXRZ1C8vxxFHfDHOeNHuUVMlUcHzq+FzvXlJBD0lo4oQzzoDHYx/xdlj9rn6qZOCF47W9zJeGvnO17h7JiVh3/2xWGtsNnCzUleh59Ke/T4xTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDgY+NRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDgY+NRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE01B1F00ACF;
	Thu, 25 Jun 2026 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782351645;
	bh=reVeQ0K6y1fWGP0+TRXUuIarxcNHMaQe8bU6sy6ZAyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QDgY+NRWbJbdAYwntntnYTnsNjN0FOhDVgte7bdH1F1KsEBmUJ6+LksKR83T5K9Cm
	 k3hLAlMlrWNYOobgnGY6SpiYdcOeOTu/7KDruZkaKRrpmMhYoDyGtfHf0D/N8aoAD3
	 GDJlrZGf7YxAjycSLk5UGeassB9UQ8FO7KoRPkK2gkK3D42EckSuP6EM5l8yntb+fc
	 Gv++urJuUoPmZdCkib0t6OWf7T1pSbmW9cij8V5dqU6vy4LK8TdYeOi0/yjU8zhnfV
	 j9FsaB5SGQU8TAYWfE7NCF4Aq8fN0vz8ZXALnuiKJfKWS/BZjtLHky8jHUYdvl5YXm
	 0FdJPh4utOlTA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 24 Jun 2026 18:38:29 -0700
Subject: [PATCH v2 1/8] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-dfustini-atl-sc-cbqri-dt-v2-1-2f8049fd902b@kernel.org>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, 
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
 yunhui cui <cuiyunhui@bytedance.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=fustini@kernel.org;
 h=from:subject:message-id; bh=sf83KK78LgG79pAz1A/Eb83woX0oPlv3EBhOYw74nG0=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWTZtEt9k07getsxMf/G4ssG+sf/CJm96tCwft24MCA4Y
 tfEqQ9udJSyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmcvctI8O/J9Ymc+tfXntU
 Va9YfW/ZpmceebEX1dZzpLuLqnO9+32TkaEh++32zdVfPLY+eHh0lVNP+j3l4CsffsWeXrHm2J2
 mumwuAA==
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
index 2b0a8a93bb21445e40ec106bdff71f4daf9563f6..1c6f091518d49aca20ecd4838c124b4983f0ef88 100644
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
2.34.1

