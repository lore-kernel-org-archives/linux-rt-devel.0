Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419F2C3770
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995616; cv=none; b=BIQWf0qPOtpF6bQkqefOyo/GHKORFue2r1zd2m+yEUHfc71gd4bRlover+BInuoFHMGk1mn7T3So2DwiEZJE1g0b1cAPLFVNbR8Op27MkGRtLdnd/7Eq+pKaUasIWxjtlUQE2+J9UsIGWmUrgDZFtIfTaSFh6PoGCIdjesvgRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995616; c=relaxed/simple;
	bh=Jc0dhpiRZygCifPSH3YR/6zM9srQWb3rDOpnC3AF1V8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6BrTI28jnMx+DxmOHzycLgJsCaUWtzw7Dzo1Wkyi4bt5F8UFgCHr+jbxMyqc5xtUrafhDbqWST39PVLaU3d2fvlaZDWKL4bqSagVzwqAGe+Lq4bkaQD2GBmArXCUno7pkrgpUwqkoyXMf+QPfiw6rfMFlthDoUGESUrHSO7ZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AE1339;
	Wed, 17 Dec 2025 10:20:05 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F02553F5CA;
	Wed, 17 Dec 2025 10:20:08 -0800 (PST)
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
	vbabka@suse.cz
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 0/2] fix wrong usage of memory allocation APIs under PREEMPT_RT in arm64
Date: Wed, 17 Dec 2025 18:20:05 +0000
Message-Id: <20251217182007.2345700-1-yeoreum.yun@arm.com>
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
from v1 to v2:
  - drop pagetable_alloc_nolock()
  - following @Ryan Roberts suggestion.
  - https://lore.kernel.org/all/20251212161832.2067134-1-yeoreum.yun@arm.com/


 arch/arm64/mm/mmu.c | 235 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 183 insertions(+), 52 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

