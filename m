Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70B1D432D
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087278; cv=none; b=JpJ260bbjjk/uTa3N0rME0BCNPrHPsi/rCog+CxjMxCsy2UsdKKNL1NKgjKWCtWSs6T/tIdt3BVfp2liO44/ObjdMd9Ozw9neEBckHY2upjj3ffEmV6BbL1Mhz/LeYrA2T57LnTfblQRTfst8Af6su0NOieBcQT9ReQlGguBoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087278; c=relaxed/simple;
	bh=NehNO/9zlpiLzlBhqStHIWNt1zbAwtSnwlDv/0EOMso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8CHzp7TbcWxQ+ExpGve23QePDsYrSCIuymDIME0OBQ5Zp6z8CB8hhvBulS66mudxTlLkzlGG3tNy+l0xSsFQrAAH/NfZvUJdxJ1BfKk+srbZHSNojt/4pgL1ByixWV29mqmdtYyluhVFoqSpVqa4qhi9Vv18dw44HkbB5uiF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C334FFEC;
	Thu, 18 Dec 2025 11:47:47 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB4F33F73F;
	Thu, 18 Dec 2025 11:47:51 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	jackmanb@google.com,
	vbabka@suse.cz,
	mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 0/2]  fix wrong usage of memory allocation APIs under PREEMPT_RT in arm64
Date: Thu, 18 Dec 2025 19:47:48 +0000
Message-Id: <20251218194750.395301-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under PREEMPT_RT, calling generic memory allocation/free APIs
(e.x) __get_free_pages(), pgtable_alloc(), free_pages() and etc
with preemption disabled is not allowed, but allow only nolock() APIs series
because it may acquire a spin lock that becomes sleepable on RT,
potentially causing a sleep during page allocation
(See Documentation/core-api/real-time/differences.rst, Memory allocation section).

However, In arm64, __linear_map_split_to_ptes() and
__kpti_install_ng_mappings() called by stopper thread via stop_machine()
use generic memory allocation/free APIs.

This patchset fixes this problem and based on v6.19-rc1

Patch History
==============
from v2 to v3:
  - remove split-mode and split_args.
    pass proper function pointer while spliting.
  - rename function name.
  - https://lore.kernel.org/all/20251217182007.2345700-1-yeoreum.yun@arm.com/

from v1 to v2:
  - drop pagetable_alloc_nolock()
  - following @Ryan Roberts suggestion.
  - https://lore.kernel.org/all/20251212161832.2067134-1-yeoreum.yun@arm.com/


*** BLURB HERE ***

Yeoreum Yun (2):
  arm64: mmu: avoid allocating pages while splitting the linear mapping
  arm64: mmu: avoid allocating pages while installing ng-mapping for
    KPTI

 arch/arm64/mm/mmu.c | 254 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 197 insertions(+), 57 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

