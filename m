Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DACD21B9C1
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366551; cv=none; b=rUvv0ZNy01Tm5+PcLpa+4uHPHO1qqN8Be+q+DUWZqyoTChrzEf6rPU0cRwI/YrFA62vSRAXfPDNWLBijgp5Aap2Kq4WxN5cOMGG9cwML+F/hJfwSZUPRgHMA/d+BAGQb24PYGHhy+jn7ILYR4lD4t7GO6lBKOLUub2d4GGv10sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366551; c=relaxed/simple;
	bh=DB4Jad8NvLeBIS1Fkx0koJ6GN5KdzGr4CC1KN67Jpfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJhSoqGlax+v1bkoqW3Geb59m5ik0pTuxfE8nN2yGfAojdAX/p1sLYKDTLObME6xkplmXtRVG+8QnpPrnvHoHw/nqVJhMrrU5RDbdPaSvZSzcRvajbg3uQCd82Eoqr8Luljhmq0j40Wu8jeKVRQo8js0TIHP//IaM+MYjB81inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0BBF497;
	Fri,  2 Jan 2026 07:09:00 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 825D03F5A1;
	Fri,  2 Jan 2026 07:09:04 -0800 (PST)
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
Subject: [PATCH v4 0/3] fix wrong usage of memory allocation APIs under PREEMPT_RT in arm64
Date: Fri,  2 Jan 2026 15:07:33 +0000
Message-Id: <20260102150736.1378818-1-yeoreum.yun@arm.com>
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
from v3 to v4:
  - rebase to v6.19-rc3
  - introduce pgtable_alloc_t
  - following several suggestions from @Ryan Roberts
  - https://lore.kernel.org/all/20251218194750.395301-1-yeoreum.yun@arm.com/

from v2 to v3:
  - remove split-mode and split_args.
    pass proper function pointer while spliting.
  - rename function name.
  - https://lore.kernel.org/all/20251217182007.2345700-1-yeoreum.yun@arm.com/

from v1 to v2:
  - drop pagetable_alloc_nolock()
  - following @Ryan Roberts suggestion.
  - https://lore.kernel.org/all/20251212161832.2067134-1-yeoreum.yun@arm.com/


Yeoreum Yun (3):
  arm64: mmu: introduce pgtable_alloc_t
  arm64: mmu: avoid allocating pages while splitting the linear mapping
  arm64: mmu: avoid allocating pages while installing ng-mapping for
    KPTI

 arch/arm64/mm/mmu.c | 243 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 188 insertions(+), 55 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

